module ut.encode.big_endian;


import ut;
import cerealed.backend.big_endian;


@("bool")
@safe pure unittest {
    false.cerealise!BigEndian.should == [0];
    true.cerealise!BigEndian.should == [1];
}


@("byte")
@safe pure unittest {
    {
        byte b = 42;
        b.cerealise!BigEndian.should == [42];
    }

    {
        byte b = 33;
        b.cerealise!BigEndian.should == [33];
    }
}


@("ubyte")
@safe pure unittest {
    {
        ubyte b = 42;
        b.cerealise!BigEndian.should == [42];
    }

    {
        ubyte b = 33;
        b.cerealise!BigEndian.should == [33];
    }
}


@("char")
@safe pure unittest {
    'a'.cerealise!BigEndian.should == ['a'];
    'b'.cerealise!BigEndian.should == ['b'];
}


@("wchar")
@safe pure unittest {
    wchar c = 0xabcd;
    c.cerealise!BigEndian.should == [0xab, 0xcd];
}
