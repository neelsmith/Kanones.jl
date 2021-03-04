
function buildparser(src::Kanones.Dataset, fstdir::AbstractString, target::AbstractString)
    if ispath(target)
        println("Cowardly refusing to overwrite exising file $(target)")
    else 
        mkdir(target)
        installalphabet(src, target)
        installsymbols(fstdir, target)
    end
end
# This is what the scala build looks like
#=
DataInstaller(dataSets, corpusList, parser)

    //println(s"Install rules for ${corpus} in ${dataDirectory}...")
    RulesInstaller(dataSets, corpusList, parser, fstSource)

    //println("Compose build")
    // Compose makefiles and higher-order FST for build system
    BuildComposer(dataSets, corpusList, parser, fstSource, conf.fstcompile)


    // Build it!
    val buildDirectory = parser / corpusList.mkString("-")
    val inflMakefile = buildDirectory / "inflection/makefile"
    val makeInfl = s"${conf.make} -f ${inflMakefile}"
    makeInfl !

    val makefile = buildDirectory / "makefile"
    val doit = s"${conf.make} -f ${makefile}"
    doit !
    =#