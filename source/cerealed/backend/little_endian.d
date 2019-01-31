module cerealed.backend.little_endian;



struct LittleEndian {

    import cerealed.backend.binary: ToBytes, FromBytes;
    import std.traits: Unqual;

    alias Cerealiser = ToBytes;
    alias Decerealiser = FromBytes;

    enum isCerealiser(C) = is(Unqual!C == Cerealiser);
    enum isDecerealiser(C) = is(Unqual!C == Decerealiser);


    static void handle(C, T)(ref scope C cereal, ref scope T value)
    {
        import cerealed.backend.binary: handleIntegral;
        import std.range: iota, retro;
        handleIntegral!LittleEndian(cereal, value, T.sizeof.iota.retro);
    }
}
