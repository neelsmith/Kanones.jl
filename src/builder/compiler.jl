"""Read data from src and fstdir and compile a SFST parser in target.
Returns the path to the compiled binary `greek.a` which can then be used
as an argument to the `parsetoken` function.
"""
function buildparser(src::Kanones.Dataset, fstdir::AbstractString, target::AbstractString)
    if ispath(target)
        println("Cowardly refusing to overwrite exising file $(target)")
    else 
        mkdir(target)
        installalphabet(src, target)
        installsymbols(fstdir, target)
        buildlexicon(src, target * "/lexicon.fst")
        buildinflection(src,target * "/inflection.fst")
        buildacceptor(src, target * "/acceptor.fst")
        buildfinalfst(src, target * "/greek.fst")
        buildmakefile(src, target * "/makefile")
        compilefst(target)
    end
    parser = target * "/greek.a"
end

function compilefst(target)
    originaldir = pwd()
    cd(target)
    @info string("Compiling fst in ", pwd())
    mk = `make`
    run(mk)
    cd(originaldir)
    @info string("Compilation complete. Working directory now ", pwd())
end

function buildmakefile(src, target)
    dir = dirname(target)
    whichcompiler = read(`which fst-compiler-utf8`, String)
    fstcompiler = replace(whichcompiler, "\n" => "")

    topline = dir * "/greek.a: " * dir * "/symbols.fst " * dir * "/acceptor.a " * dir * "/inflection.a"
    doc = join([topline,
        "\n",
        "%.a: %.fst\n",
        "\t" * fstcompiler *  raw" $< $@",
        "\n"
    ])
    open(target, "w") do io
        print(io, doc)
    end
end

function buildfinalfst(src, target)
    fstdir = dirname(target)
    doc = join([
        "%% greek.fst : a Finite State Transducer for ancient greek morphology",
        "%",
        "% All symbols used in the FST:",
        "#include \"" * fstdir * "/symbols.fst\"",
        "\n",
        "% Dynamically loaded lexica of stems:",
        raw"$stems$ = \"" * fstdir * "/lexicon.fst\"",
        "\n",
        "% Dynamically loaded inflectional rules:",
        raw"$ends$ = \"<" * fstdir * "/inflection.a>\"",
        "\n",
        "% Morphology data is the crossing of stems and endings:",
        raw"$morph$ = $stems$ <div> $ends$",
        "\n",
        "% Acceptor (1) filters for content satisfying requirements for",
        "% morphological analysis and  (2) maps from underlying to surface form",
        "% by suppressing analytical symbols, and allowing only surface strings.",
        raw"$acceptor$ = \"<" * fstdir * "/acceptor.a>\"",
        "\n",
        "% Final transducer:",
        raw"$morph$ || $acceptor$"
    ], "\n")        

    open(target, "w") do io
        print(io, doc)
    end
end

"Read all stem data and compose `lexicon.fst`."
function buildlexicon(src, target)
    iodict = Dict(
        [
        "uninflected" => UninflectedParser("uninflected"),
        "nouns" => NounParser("noun")
        ]
    )
    lexicon = []
    stemdirs = [
        "uninflected",
        "nouns"
    ]
    for dirname in stemdirs 
        dir = src.root * "/stems-tables/" * dirname * "/"
        cexfiles = glob("*.cex", dir)
        delimitedreader = (iodict[dirname])
        for f in cexfiles
            raw = readlines(f)
            lines = filter(s -> ! isempty(s), raw)
            for i in 2:length(lines)
                # FACTOR THIS OUT.  
                # Gather array of reader data from external function
                # Pipe through fst here, and push onto results
                fstline = readstemrow(delimitedreader, lines[i]) |> fst
                push!(lexicon, fstline)
            end
        end
    end
    open(target, "w") do io
        print(io, join(lexicon, "\n"))
    end
end

"Read all rules data and compose `inflection.fst`."
function buildinflection(src, target)
    iodict = Dict(
        [
        "uninflected" => UninflectedParser("uninflected"),
        "nouns" => NounParser("noun")
        ]
    )
    inflection = []
    rulesdirs = [
        "uninflected",
        "nouns"
    ]
    for dirname in rulesdirs 
        dir = src.root * "/rules-tables/" * dirname * "/"
        cexfiles = glob("*.cex", dir)
        delimitedreader = (iodict[dirname])
        for f in cexfiles
            raw = readlines(f)
            lines = filter(s -> ! isempty(s), raw)
            for i in 2:length(lines)
                # FACTOR THIS OUT.  
                # Gather array of reader data from external function
                # Pipe through fst here, and push onto results
                fstline = readrulerow(delimitedreader, lines[i]) |> fst
                push!(inflection, fstline)
            end
        end
    end
    fstvar =  raw"$inflection$"
    opening = fstvar * " = "
    closing = "\n\n" * fstvar
    open(target, "w") do io
        print(io, opening * join(inflection, " |\\\n") * closing)
    end
end
