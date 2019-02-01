import reggae;

enum debugFlags = ["-w", "-g", "-debug", "-version=Have_automem"];

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


alias ut = dubLink!(
    TargetName("ut"),
    Configuration("unittest"),
    targetConcat!(lib, testObjs, dubDependencies!(Configuration("unittest"))),
);


alias asan = dubConfigurationTarget!(
    Configuration("asan"),
    CompilerFlags(debugFlags ~ " -unittest -cov -fsanitize=address"),
    LinkerFlags("-fsanitize=address"),
);


mixin build!(ut, optional!asan);
