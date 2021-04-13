
"""Install `alphabet.fst` required to be part of an individual project.

$(SIGNATURES)
"""
function installalphabet(src::Kanones.Dataset, target::AbstractString)
    #srcfile = src.root * "/orthography/alphabet.fst"
    targetdir = target * "/symbols/"
    if ! ispath(targetdir)
        mkdir(targetdir)
    end
    targetfile = targetdir * "/alphabet.fst"
    #cp(srcfile, targetfile)
    lines = [
        "% Characters list supplied by dataset's orthography functions:",
        string("#consonant# = ", src.orthography.consonants()),
        string("#vowel# = ", src.orthography.vowels())
    ]
    open(targetfile, "w") do io
        write(io, join(lines,"\n"))
    end
    #=
    % Characters for Greek character set:
#consonant# = βγδζθκλμνξπρστφχψς
#vowel# = αειοηυω



    =#
end


"""Install symbols FST from generic FST source applying to many projects.

$(SIGNATURES)
"""
function installsymbols(src::AbstractString, target::AbstractString)
    targetdir = target * "/symbols/"
    if ! ispath(targetdir)
        mkdir(targetdir)
    end
    fstfiles = ["markup.fst", "morphsymbols.fst", "stemtypes.fst"]
    for fst in fstfiles
        srcfile = src * "/symbols/" * fst
        targetfile = targetdir * fst
        cp(srcfile, targetfile)
    end
    toplevel = target * "/symbols.fst"
    open(toplevel, "w") do io
        print(io, symbolsfst(target))
    end
    phonologyfst = open(src * "/symbols/phonology.fst","r") do phonology
        read(phonology, String)
    end
    prefix = join([
        "% phonology.fst",
        "%",
        "% Definitions of all legal symbols in stem files (lexica) except for",
        "% stem types (defined in stemtypes.fst)",
        "%",
        "% Basic alphabet specific to this orthographic system:",
        "#include \"" * target * "/symbols/alphabet.fst\""
    ], "\n")
    open(target * "/symbols/phonology.fst", "w") do io
        print(io, prefix * "\n\n" * phonologyfst * "\n")
    end
    
end

"""Compose content for top-level `symbols.fst` file.

$(SIGNATURES)
"""
function symbolsfst(dir::AbstractString)
    lines = [
        "% symbols.fst",
        "% A single include file for all symbols used in this FST.",
        "",
        "% 1. morphological tags",
        "#include \"$(dir)/symbols/morphsymbols.fst\"",
        "#include \"$(dir)/symbols/stemtypes.fst\"",
        "",        
        "% 2. ASCII representation of polytonic Greek",
        "#include \"$(dir)/symbols/phonology.fst\"",
        "",
        "% 3. Editorial symbols",
        "#include \"$(dir)/symbols/markup.fst\""
    ]
    join(lines,"\n")
end

