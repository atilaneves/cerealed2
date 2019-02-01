module cerealed.backend.little_endian;



struct LittleEndian(Output) {

    import cerealed.backend.binary: Binary;

    alias Cerealiser = Binary!Output.Cerealiser;
    alias Decerealiser = Binary!Output.Decerealiser;

    static void handle(C, T)(ref scope C cereal, ref scope T value)
    {
        import std.range: iota, retro;
        Binary!Output.handleIntegral(cereal, value, T.sizeof.iota.retro);
    }
}
