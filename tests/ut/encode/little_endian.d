module ut.encode.little_endian;


import ut;
import cerealed.backend.little_endian;


@("bool")
@safe pure unittest {
    false.cerealise!LittleEndian.should == [0];
    true.cerealise!LittleEndian.should == [1];
}


@("byte")
@safe pure unittest {
    {
        byte b = 42;
        b.cerealise!LittleEndian.should == [42];
    }

    {
        byte b = 33;
        b.cerealise!LittleEndian.should == [33];
    }
}


@("ubyte")
@safe pure unittest {
    {
        ubyte b = 42;
        b.cerealise!LittleEndian.should == [42];
    }

    {
        ubyte b = 33;
        b.cerealise!LittleEndian.should == [33];
    }
}


@("char")
@safe pure unittest {
    'a'.cerealise!LittleEndian.should == ['a'];
    'b'.cerealise!LittleEndian.should == ['b'];
}


@("wchar")
@safe pure unittest {
    wchar c = 0xabcd;
    c.cerealise!LittleEndian.should == [0xcd, 0xab];
}