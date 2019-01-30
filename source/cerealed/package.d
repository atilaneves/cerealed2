module cerealed;


import cerealed.from;


alias cerealize = cerealise;


auto cerealise(B = from!"cerealed.backend.big_endian".BigEndian, T)
              (in T value)
    if(T.sizeof == 1)
{
    auto backend = B.Cerealiser();
    backend.handleOctet(value);
    return backend.bytes.dup;
}


auto cerealise(B = from!"cerealed.backend.big_endian".BigEndian, T)
              (in T value)
    if(T.sizeof == 2)
{
    auto backend = B.Cerealiser();
    backend.handleWord(value);
    return backend.bytes.dup;
}


T decerealise(T, B = from!"cerealed.backend.big_endian".BigEndian)
             (in ubyte[] bytes)
{
    T ret = void;
    auto backend = B.Decerealiser(bytes);
    backend.handle(ret);
    return ret;
}
