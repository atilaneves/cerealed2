import reggae;

enum debugFlags = ["-w", "-g", "-debug"];

alias lib = dubConfigurationTarget!(
    Configuration("library"),
    CompilerFlags(debugFlags),
    LinkerFlags(),
    No.main,
    CompilationMode.package_,
);


alias testObjs = dlangObjectsPerModule!(
    Sources!"tests",
    CompilerFlags(debugFlags ~ ["-unittest"]),
    dubImportPaths!(Configuration("unittest"))
);

alias testObjsLight = dlangObjectsPerModule!(
    Sources!"tests",
    CompilerFlags(debugFlags ~ ["-unittest", "-version=unitThreadedLight"]),
    dubImportPaths!(Configuration("unittest"))
);



alias ut = dubLink!(
    TargetName("ut"),
    Configuration("unittest"),
    targetConcat!(lib, testObjs, dubDependencies!(Configuration("unittest"))),
);


alias utl = dubLink!(
    TargetName("utl"),
    Configuration("unittest"),
    targetConcat!(lib, testObjsLight, dubDependencies!(Configuration("unittest"))),
);


mixin build!(ut, optional!utl);
