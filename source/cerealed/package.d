module cerealed;


ubyte[] cerealise(bool b) @safe pure {
    return b ? [1] : [0];
}
