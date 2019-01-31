/**
   Common to big and little endian.
 */
module cerealed.backend.binary;



package struct ToBytes {

    ubyte[] bytes;

    void handleOctet(T)(ref const(T) value) if(T.sizeof == 1) {
        bytes ~= value;
    }
}


package struct FromBytes {

    const(ubyte)[] bytes;

    void handleOctet(T)(ref T value) if(T.sizeof == 1) {
        value = cast(T) bytes[0];
        bytes = bytes[1..$];
    }
}


package void handleIntegral(B, C, T, R)(ref scope C cereal, ref scope T value, R range)
{
    static if(B.isDecerealiser!C)
        T newVal = 0;

    foreach(i; range) {

        const shiftBy = T.sizeof * 8 - (i + 1) * 8;

        static if(B.isCerealiser!C)
            ubyte byteVal = (value >> shiftBy) & 0xff;
        else
            ubyte byteVal = void;

        cereal.handleOctet(byteVal);

        static if(B.isDecerealiser!C)
            newVal = cast(T) (newVal | (byteVal << shiftBy));
    }

    static if(B.isDecerealiser!C)
        value = newVal;
}
