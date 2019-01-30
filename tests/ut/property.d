module ut.property;


import ut;
import cerealed;


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


@UnitTest
@Types!(
    bool, byte, ubyte, char,
    // wchar is throwing an invalid UTF sequence but seems to work otherwise
    /*wchar, */ short, ushort,
)
void thereAndBackAgainJSON(T)() @safe {
    check!((T val) => val.cerealise!JSON.decerealise!(T, JSON) == val);
}
