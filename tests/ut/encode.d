module ut.encode;


import ut;


@("bool")
@safe pure unittest {
    false.cerealise.should == [0];
    true.cerealise.should == [1];
}
