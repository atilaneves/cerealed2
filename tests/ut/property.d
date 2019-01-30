module ut.property;


import ut;
import cerealed;
import cerealed.backend.big_endian;


@UnitTest
@Types!(bool, byte, ubyte, char)
void thereAndBackAgain(T)() @safe {
    check!((T val) => val.cerealise.decerealise!T == val);
}
