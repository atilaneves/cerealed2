module ut.encode.little_endian;


import ut;


@("bool")
@safe pure unittest {
    false.cerealise.should == [0];
    true.cerealise.should == [1];
}


@("byte")
@safe pure unittest {
    {
        byte b = 42;
        b.cerealise.should == [42];
    }

    {
        byte b = 33;
        b.cerealise.should == [33];
    }
}


@("ubyte")
@safe pure unittest {
    {
        ubyte b = 42;
        b.cerealise.should == [42];
    }

    {
        ubyte b = 33;
        b.cerealise.should == [33];
    }
}


@("char")
@safe pure unittest {
    'a'.cerealise.should == ['a'];
    'b'.cerealise.should == ['b'];
}
