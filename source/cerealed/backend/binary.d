/**
   Common to big and little endian.
 */
module cerealed.backend.binary;



struct ToBytes {

    ubyte[] bytes;

    void handleOctet(T)(ref const(T) value) if(T.sizeof == 1) {
        bytes ~= value;
    }
}


struct FromBytes {

    const(ubyte)[] bytes;

    void handleOctet(T)(ref T value) if(T.sizeof == 1) {
        value = cast(T) bytes[0];
        bytes = bytes[1..$];
    }
}
