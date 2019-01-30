module ut.encode.big_endian;


import ut;
import cerealed.backend.big_endian;


@("bool")
@safe pure unittest {
    false.cerealise.should == [0];
    true.cerealise.should == [1];
}


@("byte")
@safe pure unittest {
    {
        const byte b = 42;
        b.cerealise.should == [42];
    }

    {
        const byte b = 33;
        b.cerealise.should == [33];
    }
}


@("ubyte")
@safe pure unittest {
    {
        const ubyte b = 42;
        b.cerealise.should == [42];
    }

    {
        const ubyte b = 33;
        b.cerealise.should == [33];
    }
}


@("char")
@safe pure unittest {
    'a'.cerealise.should == ['a'];
    'b'.cerealise.should == ['b'];
}


@("wchar")
@safe pure unittest {
    const wchar c = 0xabcd;
    c.cerealise.should == [0xab, 0xcd];
}
