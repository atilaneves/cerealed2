/**
   Common to big and little endian.
 */
module cerealed.backend.binary;


struct Binary(Output) {

    import std.traits: Unqual;

    alias Cerealiser = ToBytes!Output;
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
