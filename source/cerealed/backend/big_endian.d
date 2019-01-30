module cerealed.backend.big_endian;


struct BigEndian {
    alias Cerealiser = ToBytes;
    alias Decerealiser = FromBytes;
}


struct ToBytes {

    ubyte[] bytes;

    void handleOctet(T)(ref T value) if(T.sizeof == 1) {
        bytes ~= value;
    }

    void handleWord(T)(ref T value) if(T.sizeof == 2) {
        const hi = cast(ubyte) (value >> 8);
        const ubyte lo = value & 0x00ff;
        handleOctet(hi);
        handleOctet(lo);
    }
}


struct FromBytes {

    const(ubyte)[] bytes;

    void handle(T)(ref T value) if(T.sizeof == 1) {
        value = cast(T) bytes[0];
    }
}
