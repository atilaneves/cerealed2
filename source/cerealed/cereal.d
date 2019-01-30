module cerealed.cereal;


import cerealed.from;


alias cerealize = cerealise;
alias decerealize = decerealise;


auto cerealise(Backend = from!"cerealed.backend.big_endian".BigEndian, T)
              (in T value)
{
    auto cereal = Backend.Cerealiser();
    Backend.handle(cereal, value);
    return cereal.bytes;
}


T decerealise(T, Backend = from!"cerealed.backend.big_endian".BigEndian)
             (in ubyte[] bytes)
{
    auto ret = T.init;
    auto cereal = Backend.Decerealiser(bytes);
    Backend.handle(cereal, ret);
    return ret;
}
