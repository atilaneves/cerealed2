module ut.decode.json;


import ut;


@("float")
@safe unittest {
    "3.3".decerealise!(float, JSON).should == 3.3f;
}
