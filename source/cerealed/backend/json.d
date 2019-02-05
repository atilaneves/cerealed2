module cerealed.backend.json;


struct JSON {

    alias Cerealiser = ToString;
    alias Decerealiser = FromString;

    static void handle(C, T)(ref scope C cereal, ref scope T value) {
        cereal.handle(value);
    }
}


struct ToString {

    char[] bytes;

    void handle(T)(ref T value) {
        import std.conv: text;
        bytes ~= value.text;
    }
}


struct FromString {

    const(char)[] bytes;

    this(const(char)[] bytes) @safe @nogc pure {
        this.bytes = bytes;
    }

    this(const(ubyte)[] bytes) @safe pure {
        import std.string: assumeUTF;
        this.bytes = bytes.assumeUTF;
    }

    void handle(T)(ref T value) {
        import std.conv: to;
        value = bytes.to!T;
    }
}
