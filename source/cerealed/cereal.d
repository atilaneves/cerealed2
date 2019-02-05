module cerealed.cereal;


import cerealed.from;


alias cerealize = cerealise;
alias decerealize = decerealise;


alias DefaultBackend = from!"cerealed.backend.big_endian".BigEndian;
alias DefaultOutput = from!"std.array".Appender!(ubyte[]);


version(Have_automem) {

    alias cerealizeThen = cerealiseThen;

    /**
       Instead of having to worry about allocation and lifetimes for the
       serialised bytes, apply a function after serialisation.
       This is usually faster.
     */
    auto cerealiseThen(alias F, alias Backend = DefaultBackend, T)
                      (in T value)
    {
        import automem.vector: Vector;
        import stdx.allocator.showcase: StackFront;
        import stdx.allocator.mallocator: Mallocator;

        alias Output = Vector!(ubyte, StackFront!(1024, Mallocator));

        auto cereal = Backend!Output.Cerealiser();
        Backend!Output.handle(cereal, value);

        return F(cereal.bytes);
    }
}


auto cerealise(Backend = DefaultBackend!DefaultOutput, T)
              (in T value)
{
    auto cereal = Backend.Cerealiser();
    Backend.handle(cereal, value);
    return cereal.bytes;
}


T decerealise(T, Backend = DefaultBackend!DefaultOutput, R)
             (R range)
    @safe
    if(from!"std.range.primitives".isInputRange!R)
{
    auto ret = T.init;
    auto cereal = Backend.Decerealiser(range);
    Backend.handle(cereal, ret);
    return ret;
}
