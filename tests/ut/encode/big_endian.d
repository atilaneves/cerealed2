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


@("short")
@safe pure unittest {
    const short c = 0x4bcd;
    c.cerealise.should == [0x4b, 0xcd];
}


@("ushort.gc")
@safe pure unittest {
    const ushort c = 0xabcd;
    c.cerealise.should == [0xab, 0xcd];
}


@("ushort.nogc.ret")
@safe unittest {

    import automem.vector: Vector;
    import stdx.allocator.mallocator: Mallocator;

    const ushort c = 0xabcd;
    auto bytes = () @nogc { return c.cerealise!(BigEndian!(Vector!(ubyte, Mallocator))); }();
    c.cerealise.should == [0xab, 0xcd];
}


@("ushort.nogc.then")
@safe @nogc unittest {
    import cerealed: cerealiseThen;
    const ushort c = 0xabcd;

    void fun(in ubyte[] bytes) {
        ubyte[2] expected = [0xab, 0xcd];
        assert(bytes == expected);
    }

    c.cerealiseThen!fun;
}
