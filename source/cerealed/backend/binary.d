/**
   Common to big and little endian.
 */
module cerealed.backend.binary;


struct Binary(Output) {

    import std.traits: Unqual, isFloatingPoint;

    alias Cerealiser = ToBytes!Output;
    alias Decerealiser = FromBytes;

    enum isCerealiser(C) = is(Unqual!C == Cerealiser);
    enum isDecerealiser(C) = is(Unqual!C == Decerealiser);

    private template isIntegral(T) {
        import std.traits: isIntegral_ = isIntegral, isSomeChar, isBoolean, isFloatingPoint;
        enum isIntegral = isIntegral_!T || isSomeChar!T || isBoolean!T;
    }

    package static void handle(C, T, R)(ref scope C cereal, ref scope T value, R range)
        if(isIntegral!T)
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

            static if(Binary.isDecerealiser!C) {
                const byteValAsT = cast(T) byteVal;
                newVal = cast(T) (newVal | (byteValAsT << shiftBy));
            }
        }

        static if(Binary.isDecerealiser!C)
            value = newVal;
    }

    package static void handle(C, T, R)(ref scope C cereal, ref scope T value, R range)
        if(isFloatingPoint!T)
    {
        static if(T.sizeof == 4)
            alias Int = uint;
        else static if(T.sizeof == 8)
            alias Int = ulong;
        else
            static assert(false, "Unknown floating point type " ~ T.stringof);

        auto bits = () @trusted { return *(cast(Int*) &value); }();

        handle(cereal, bits, range);

        static if(Binary.isDecerealiser!C)
            value = () @trusted { return *(cast(T*) &bits); }();
    }
}


private struct ToBytes(Output) {

    private Output _output;

    void handleOctet(T)(ref const(T) value) if(T.sizeof == 1) {
        _output.put(cast(ubyte) value);
    }

    auto bytes() @safe @nogc pure nothrow inout {
        static if(__traits(compiles, _output[]))
            return _output[];
        else
            return _output.data;
    }
}


private struct FromBytes {

    const(ubyte)[] bytes;

    void handleOctet(T)(ref T value) if(T.sizeof == 1) {
        value = cast(T) bytes[0];
        bytes = bytes[1..$];
    }
}
