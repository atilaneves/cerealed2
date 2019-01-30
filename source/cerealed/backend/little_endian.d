module cerealed.backend.little_endian;


struct LittleEndian {

    alias Cerealiser = ToBytes;
    alias Decerealiser = FromBytes;

    static void handle(C, T)(ref scope C cereal, ref scope T value)
        if(T.sizeof == 1)
    {
        cereal.handleOctet(value);
    }


    static void handle(C, T)(ref scope C cereal, ref scope T value)
        if(T.sizeof == 2)
    {
        const hi = cast(ubyte) (value >> 8);
        const ubyte lo = value & 0x00ff;
        cereal.handleOctet(lo);
        cereal.handleOctet(hi);
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
    }

    void handle(T)(ref T value) if(T.sizeof == 2) {
        value = cast(T) ((bytes[0] << 8) | bytes[1]);
    }
}
