/**
   Common to big and little endian.
 */
module cerealed.backend.binary;


struct Binary {

    import std.traits: Unqual;

    alias Cerealiser = ToBytes;
    alias Decerealiser = FromBytes;

    enum isCerealiser(C) = is(Unqual!C == Cerealiser);
    enum isDecerealiser(C) = is(Unqual!C == Decerealiser);

    package static void handleIntegral(C, T, R)(ref scope C cereal, ref scope T value, R range)
    {
        static if(Binary.isDecerealiser!C)
            T newVal = 0;

        foreach(i; range) {

            const shiftBy = T.sizeof * 8 - (i + 1) * 8;

            static if(Binary.isCerealiser!C)
                ubyte byteVal = (value >> shiftBy) & 0xff;
            else
                ubyte byteVal = void;

            cereal.handleOctet(byteVal);

            static if(Binary.isDecerealiser!C)
                newVal = cast(T) (newVal | (byteVal << shiftBy));
        }

        static if(Binary.isDecerealiser!C)
            value = newVal;
    }
}


private struct ToBytes {

    ubyte[] bytes;

    void handleOctet(T)(ref const(T) value) if(T.sizeof == 1) {
        bytes ~= value;
    }
}


private struct FromBytes {

    const(ubyte)[] bytes;

    void handleOctet(T)(ref T value) if(T.sizeof == 1) {
        value = cast(T) bytes[0];
        bytes = bytes[1..$];
    }
}
