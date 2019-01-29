module cerealed;


ubyte[] cerealise(T)(in T value) if(T.sizeof == 1) {
    return [value];
}


ubyte[] cerealise(T)(in T value) if(T.sizeof == 2) {
    return [cast(ubyte) (value >> 8), cast(ubyte) (value & 0x00ff)];
}
