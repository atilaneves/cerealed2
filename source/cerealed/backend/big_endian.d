module cerealed.backend.big_endian;



struct BigEndian {

    import cerealed.backend.binary: Binary;

    alias Cerealiser = Binary.Cerealiser;
    alias Decerealiser = Binary.Decerealiser;

    static void handle(C, T)(ref scope C cereal, ref scope T value)
    {
        import std.range: iota;
        Binary.handleIntegral(cereal, value, T.sizeof.iota);
    }
}
