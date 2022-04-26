
"""Check if path exists, and remove it if force is true.
$(SIGNATURES)
"""
function checktarget(path, force::Bool)
    if ispath(path) && force
        @info("Recursively deleting ", path)
        rm(path, force = true, recursive = true)
    end
end

"""Read data from src and fstdir and compile a SFST parser in target.

$(SIGNATURES)

Returns the path to the compiled binary `greek.a` which can then be used
as an argument to the `parsetoken` function.
"""
function buildparser(src::Kanones.Dataset, fstdir::AbstractString, target::AbstractString, label = "Kanones parser"; force::Bool = false)
    checktarget(target, force)
    if ispath(target)
        @warn("Cowardly refusing to overwrite exising file $(target)")
        
    else 
        mkdir(target)
        # Translate tabular data to FST
        buildlexicon(src, joinpath(target, "lexicon.fst"))
        buildinflection(src,joinpath(target, "inflection.fst"))

        # Install alphabet from dataset's orthography:
        installalphabet(src, target)

        # Copy FST source files to target
        installsymbols(fstdir, target)

        # Automatically composed FST, based on path to target directory.
        buildfinalfst(joinpath(target, "greek.fst"))
        buildacceptor(joinpath(target, "acceptor.fst"))
        buildmakefile(joinpath(target, "makefile"))
        
        # Compile SFST binary
        compilefst(target)
    end
    Kanones.KanonesParser(label, joinpath(target, "greek.a"))
end

"""Compile binary parser with `make`.

$(SIGNATURES)

# Arguments

- `target` is a directory with a `makefile`.

"""
function compilefst(target)
    originaldir = pwd()
    cd(target)
    @info string("Compiling fst in ", pwd())
    mk = `make`
    run(mk)
    cd(originaldir)
    @info string("Compilation complete. Working directory now ", pwd())
end


"""Compose `makefile`.

$(SIGNATURES)

# Arguments

- `src` is a `Kanones.Dataset`.  
- `target` is the full path to the desination file `makefile`.
"""
function buildmakefile(target)
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

"""Compose top-level transducer `greek.fst`.

$(SIGNATURES)

# Arguments

- `target` is the full path to the desination file `greek.fst`.
"""
function buildfinalfst(target)
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

"""Read all stem data and compose `lexicon.fst`.

$(SIGNATURES)

# Arguments

- `src` is a `Kanones.Dataset`.  
- `target` is the full path to the desination file `lexicon.fst`.
"""
function buildlexicon(src, target)
     stems = Kanones.stemsarray(src)
     lexicon = []
     for s in stems
        push!(lexicon, fst(s; ortho = src.orthography))
     end
    open(target, "w") do io
        print(io, join(lexicon, "\n"))
    end
end


"""
Read all rules data and compose `inflection.fst`.

$(SIGNATURES)

# Arguments

- `src` is a `Kanones.Dataset`.  
- `target` is the full path to the desination file `inflection.fst`.
"""
function buildinflection(src::Kanones.Dataset, target)
    ruleset = Kanones.rulesarray(src)
    inflection = []
    for r in ruleset
        push!(inflection, fst(r; ortho = src.orthography))
    end
    fstvar =  raw"$inflection$"
    opening = fstvar * " = "
    closing = "\n\n" * fstvar
    open(target, "w") do io
        print(io, opening * join(inflection, " |\\\n") * closing)
    end
end
