module cerealed;


import cerealed.from;


alias cerealize = cerealise;


auto cerealise(B = from!"cerealed.backend.big_endian".BigEndian, T)
              (in T value)
    if(T.sizeof == 1)
{
    auto backend = B();
    backend.handleOctet(value);
    return backend.bytes.dup;
}


auto cerealise(B = from!"cerealed.backend.big_endian".BigEndian, T)
              (in T value)
    if(T.sizeof == 2)
{
    auto backend = B();
    backend.handleWord(value);
    return backend.bytes.dup;
}
