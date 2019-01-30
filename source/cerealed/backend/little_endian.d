module cerealed.backend.little_endian;



struct LittleEndian {

    import std.traits: Unqual;

    alias Cerealiser = ToBytes;
    alias Decerealiser = FromBytes;

    enum isCerealiser(C) = is(Unqual!C == Cerealiser);
    enum isDecerealiser(C) = is(Unqual!C == Decerealiser);


    static void handle(C, T)(ref scope C cereal, ref scope T value)
        if(T.sizeof == 1)
    {
        cereal.handleOctet(value);
    }


    static void handle(C, T)(ref scope C cereal, ref scope T value)
        if(T.sizeof == 2)
    {
        import std.traits: Unqual;

        static if(isCerealiser!C) {
            auto hi = cast(ubyte) (value >> 8);
            ubyte lo = value & 0x00ff;
        } else {
            ubyte hi = void;
            ubyte lo = void;
        }

        cereal.handleOctet(lo);
        cereal.handleOctet(hi);

        static if(isDecerealiser!C)
            value = cast(T) ((hi << 8) | lo);
    }
}


struct ToBytes {

    ubyte[] bytes;

    void handleOctet(T)(ref T value) if(T.sizeof == 1) {
        bytes ~= value;
    }
}


struct FromBytes {

    const(ubyte)[] bytes;

    void handleOctet(T)(ref T value) if(T.sizeof == 1) {
        value = cast(T) bytes[0];
        bytes = bytes[1..$];
    }
}
