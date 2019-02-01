module ut.encode.little_endian;


import ut;
import cerealed.backend.little_endian;


alias Backend = LittleEndian!DefaultOutput;


@("bool")
@safe pure unittest {
    false.cerealise!Backend.should == [0];
    true.cerealise!Backend.should == [1];
}


@("byte")
@safe pure unittest {
    {
        const byte b = 42;
        b.cerealise!Backend.should == [42];
    }

    {
        const byte b = 33;
        b.cerealise!Backend.should == [33];
    }
}


@("ubyte")
@safe pure unittest {
    {
        const ubyte b = 42;
        b.cerealise!Backend.should == [42];
    }

    {
        const ubyte b = 33;
        b.cerealise!Backend.should == [33];
    }
}


@("char")
@safe pure unittest {
    'a'.cerealise!Backend.should == ['a'];
    'b'.cerealise!Backend.should == ['b'];
}


@("wchar")
@safe pure unittest {
    const wchar c = 0xabcd;
    c.cerealise!Backend.should == [0xcd, 0xab];
}


@("short")
@safe pure unittest {
    const short c = 0x4bcd;
    c.cerealise!Backend.should == [0xcd, 0x4b];
}


@("ushort")
@safe pure unittest {
    const ushort c = 0xabcd;
    c.cerealise!Backend.should == [0xcd, 0xab];
}
