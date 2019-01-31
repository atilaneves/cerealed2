module cerealed.backend.little_endian;



struct LittleEndian {

    import cerealed.backend.binary: Binary;

    alias Cerealiser = Binary.Cerealiser;
    alias Decerealiser = Binary.Decerealiser;

    static void handle(C, T)(ref scope C cereal, ref scope T value)
    {
        import std.range: iota, retro;
        Binary.handleIntegral(cereal, value, T.sizeof.iota.retro);
    }
}
