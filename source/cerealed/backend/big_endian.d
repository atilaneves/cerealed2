module cerealed.backend.big_endian;


struct BigEndian {

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
