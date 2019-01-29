module ut.encode.big_endian;


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
