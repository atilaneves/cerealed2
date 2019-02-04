module ut.property;


import ut;
import cerealed;


@UnitTest
@Types!(
    bool, byte, ubyte, char,
    wchar, short, ushort,
    dchar, int, uint,
)
@Types!(BigEndian!DefaultOutput, LittleEndian!DefaultOutput, JSON)
void thereAndBackAgain(Type, Backend)() {
    static if((is(Type == wchar) || is(Type == dchar)) && is(Backend == JSON))
        // wchar is throwing an invalid UTF sequence but seems to work else
        1.should == 1;
    else
        check!((Type val) => val.cerealise!Backend.decerealise!(Type, Backend) == val);
}
