module ut.encode.json;


import ut;
import cerealed;
import cerealed.backend.json;
import std.conv: to;


@("bool")
@safe pure unittest {
    false.cerealise!Json.should == `false`;
    true.cerealise!Json.should == `true`;
}


@("byte")
@safe pure unittest {
    {
        const byte b = 42;
        b.cerealise!Json.should == "42";
    }

    {
        const byte b = 33;
        b.cerealise!Json.should == "33";
    }
}


@("ubyte")
@safe pure unittest {
    {
        const ubyte b = 42;
        b.cerealise!Json.should == "42";
    }

    {
        const ubyte b = 33;
        b.cerealise!Json.should == "33";
    }
}


@("char")
@safe pure unittest {
    'a'.cerealise!Json.should == "a";
    'b'.cerealise!Json.should == "b";
}


@("wchar")
@safe pure unittest {
    const wchar c = "a"w[0];
    c.cerealise!Json.should == "a";
}
