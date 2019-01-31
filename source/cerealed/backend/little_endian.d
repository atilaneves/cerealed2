module cerealed.backend.little_endian;



struct LittleEndian {

    import cerealed.backend.binary: ToBytes, FromBytes;
    import std.traits: Unqual;

    alias Cerealiser = ToBytes;
    alias Decerealiser = FromBytes;

    enum isCerealiser(C) = is(Unqual!C == Cerealiser);
    enum isDecerealiser(C) = is(Unqual!C == Decerealiser);


    static void handle(C, T)(ref scope C cereal, ref scope T value)
    {
        static if(isDecerealiser!C)
            T newVal = 0;

        for(int i = T.sizeof - 1; i >= 0; --i) {

            const shiftBy = T.sizeof * 8 - (i + 1) * 8;

            static if(isCerealiser!C)
                ubyte byteVal = (value >> shiftBy) & 0xff;
            else
                ubyte byteVal = void;

            cereal.handleOctet(byteVal);

            static if(isDecerealiser!C)
                newVal = cast(T) (newVal | (byteVal << shiftBy));
        }

        static if(isDecerealiser!C)
            value = newVal;
    }
}
