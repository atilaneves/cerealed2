import unit_threaded.runner;


mixin runTestsMain!(
    "ut.property",

    "ut.encode.big_endian",
    "ut.encode.little_endian",
    "ut.encode.json",

    "ut.decode.big_endian",
    "ut.decode.json",
);
