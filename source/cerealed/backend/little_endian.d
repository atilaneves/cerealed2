module cerealed.backend.little_endian;


struct LittleEndian {

    ubyte[] bytes;

    void handleOctet(T)(ref T value) if(T.sizeof == 1) {
        bytes ~= value;
    }

    void handleWord(T)(ref T value) if(T.sizeof == 2) {
        const hi = cast(ubyte) (value >> 8);
        const ubyte lo = value & 0x00ff;
        handleOctet(lo);
        handleOctet(hi);
    }
}
