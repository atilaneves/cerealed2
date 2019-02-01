module cerealed.backend.big_endian;



struct BigEndian(Output) {

    import cerealed.backend.binary: Binary;

    alias Cerealiser = Binary!Output.Cerealiser;
    alias Decerealiser = Binary!Output.Decerealiser;

    static void handle(C, T)(ref scope C cereal, ref scope T value)
    {
        import std.range: iota;
        Binary!Output.handleIntegral(cereal, value, T.sizeof.iota);
    }
}
