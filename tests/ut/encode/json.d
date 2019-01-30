module ut.encode.json;


import ut;
import cerealed;
import cerealed.backend.json;
import std.conv: to;


@("bool")
@safe pure unittest {
    false.cerealise!JSON.should == `false`;
    true.cerealise!JSON.should == `true`;
}


@("byte")
@safe pure unittest {
    {
        const byte b = 42;
        b.cerealise!JSON.should == "42";
    }

    {
        const byte b = 33;
        b.cerealise!JSON.should == "33";
    }
}


@("ubyte")
@safe pure unittest {
    {
        const ubyte b = 42;
        b.cerealise!JSON.should == "42";
    }

    {
        const ubyte b = 33;
        b.cerealise!JSON.should == "33";
    }
}


@("char")
@safe pure unittest {
    'a'.cerealise!JSON.should == "a";
    'b'.cerealise!JSON.should == "b";
}


@("wchar")
@safe pure unittest {
    const wchar c = "a"w[0];
    c.cerealise!JSON.should == "a";
}


@("short")
@safe pure unittest {
    const short c = 12345;
    c.cerealise!JSON.should == "12345";
}


@("ushort")
@safe pure unittest {
    const ushort c = 12345;
    c.cerealise!JSON.should == "12345";
}
