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

    char[] bytes;

    void handle(T)(ref T value) {
        import std.conv: to;
        value = bytes.to!T;
    }
}
