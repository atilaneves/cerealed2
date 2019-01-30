module cerealed.backend.json;


struct JSON {
    alias Cerealiser = ToString;
}


struct ToString {

    char[] bytes;

    void handleOctet(T)(ref T value) if(T.sizeof == 1) {
        import std.conv: text;
        bytes ~= value.text;
    }

    void handleWord(T)(ref T value) if(T.sizeof == 2) {
        import std.conv: text;
        bytes ~= value.text;
    }
}
