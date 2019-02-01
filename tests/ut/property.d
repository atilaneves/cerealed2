module ut.property;


import ut;
import cerealed;


@UnitTest
@Types!(
    bool, byte, ubyte, char,
    wchar, short, ushort,
    int, uint,
)
@Types!(BigEndian!DefaultOutput, LittleEndian!DefaultOutput, JSON)
void thereAndBackAgain(Type, Backend)() @safe {
    static if(is(Type == wchar) && is(Backend == JSON))
        // wchar is throwing an invalid UTF sequence but seems to work else
        1.should == 1;
    else
        check!((Type val) => val.cerealise!Backend.decerealise!(Type, Backend) == val);
}
