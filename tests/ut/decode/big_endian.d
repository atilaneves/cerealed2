module ut.decode.big_endian;


import ut;


@("ulong")
@safe pure unittest {
    ubyte[] bytes = [0x00, 0x00, 0x00, 0x06, 0x89, 0x30, 0xca, 0xd8];
    bytes.decerealise!ulong.should == 0x68930cad8;
}


@("float")
@system pure unittest {
    ubyte[] bytes = [0x00, 0x11, 0x22, 0x33];
    const floatValue = bytes.decerealise!float;
    const intValue = *(cast(int*) &floatValue);
    intValue.should == 0x00112233;
}
