module ut.property;


import ut;
import cerealed;
import cerealed.backend.big_endian;


@UnitTest
@Types!(
    bool, byte, ubyte, char,
    wchar, short, ushort,
)
void thereAndBackAgainBig(T)() @safe {
    check!((T val) => val.cerealise.decerealise!T == val);
}


@UnitTest
@Types!(
    bool, byte, ubyte, char,
    wchar, short, ushort,
)
void thereAndBackAgainLittle(T)() @safe {
    check!((T val) => val.cerealise!LittleEndian.decerealise!(T, LittleEndian) == val);
}
