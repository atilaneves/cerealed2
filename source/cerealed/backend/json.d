module cerealed.backend.json;


struct Json {

    char[] bytes;

    void handleOctet(T)(ref T value) if(T.sizeof == 1) {
        import std.conv: text;
        bytes ~= value.text;
    }

    void handleWord(T)(ref T value) if(T.sizeof == 2) {
        import std.conv: test;
        bytes ~= value.text;
    }
}
