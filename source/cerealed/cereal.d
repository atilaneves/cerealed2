module cerealed.cereal;


import cerealed.from;


alias cerealize = cerealise;
alias decerealize = decerealise;


alias DefaultBackend = from!"cerealed.backend.big_endian".BigEndian;


auto cerealise(Backend = DefaultBackend, T)
              (in T value)
{
    auto cereal = Backend.Cerealiser();
    Backend.handle(cereal, value);
    return cereal.bytes;
}


T decerealise(T, Backend = DefaultBackend, R)
             (R range)
    if(from!"std.range.primitives".isInputRange!R)
{
    auto ret = T.init;
    auto cereal = Backend.Decerealiser(range);
    Backend.handle(cereal, ret);
    return ret;
}
