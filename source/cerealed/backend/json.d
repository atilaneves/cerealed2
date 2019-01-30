module cerealed.backend.json;


struct Json {

    char[] bytes;

    void handleOctet(T)(ref T value) if(T.sizeof == 1) {
        import std.conv: text;
        bytes ~= value.text;
    }

    void handleWord(T: wchar)(ref T value) {
        import std.conv: text;
        bytes ~= value.text;
    }
}
