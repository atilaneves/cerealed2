module cerealed.backend.big_endian;


struct BigEndian {

    ubyte[] bytes;

    void handleOctet(T)(ref T value) if(T.sizeof == 1) {
        bytes ~= value;
    }

    void handleWord(T)(ref T value) if(T.sizeof == 2) {
        ubyte hi = value >> 8;
        ubyte lo = value & 0x00ff;
        handleOctet(hi);
        handleOctet(lo);
    }
}
