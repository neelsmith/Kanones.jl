
"""
A Kanones dataset in a local file system.  

# Members

- `dirs` is a list of full paths to the root directory of one or more datasets.  
Their subdirectory organization must follow Kanones' specifications.
- `orthography` is an implementation of the `GreekOrthography` interface
"""
struct Dataset
    dirs
    orthography::GreekOrthography
    function Dataset(dirlist; ortho::T = literaryGreek()) where {T <: GreekOrthography}
        if isempty(rulesarray(dirlist))
            #throw(ArgumentError("No inflectional rules found."))
            @warn("No inflectional rules found for $(dirlist).")

        elseif isempty(stemsarray(dirlist))
            #throw(ArgumentError("No lexicon of stems found."))
            @warn("No lexicon of stems found for $(dirlist).")
        # elseif ## if no urn registry ...
        # need to enforce referential integrity of data
        # with registry
            
        end   
        new(dirlist, ortho)
    end
end

"""Create a `Kanones.Dataset` from a single data source.

$(SIGNATURES)

# Arguments

- `dir` Full path to a directory with Kanones data.
- `ortho` An instance of a `GreekOrthography`; defaults to `LiteraryGreekOrthography`.
"""
function dataset(dir::AbstractString; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    Kanones.Dataset([dir]; ortho = ortho)
end



"""Create a `Kanones.Dataset` from one or more data sources.

$(SIGNATURES)

# Arguments

- `srclist` List of full paths to a directory with Kanones data.
- `ortho` An instance of a `GreekOrthography`; defaults to `LiteraryGreekOrthography`.
"""
function dataset(srclist::Array; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    Kanones.Dataset(srclist; ortho =  ortho)
end


"""Read all rules data from a list of directories into an array of `Rule`s.

$(SIGNATURES)
"""
function rulesarray(kd::Kanones.Dataset; delimiter = "|")
    rulesarray(kd.dirs, delimiter = delimiter)
end

"""Read all rules data from a `Kanones.Dataset` into an array of `Rule`s.

$(SIGNATURES)
"""
function rulesarray(dirlist; delimiter = "|")
    iodict = Dict(
        [
        "uninflected" => UninflectedIO("uninflected"),
        "irregulars" => IrregularRuleParser("irregulars"),
        "nouns" => NounIO("noun"),
        "pronouns" => PronounIO("noun"),
        "adjectives" => AdjectiveIO("adjectives"),
        "finiteverbs" => VerbIO("verb"),
        "infinitives" => InfinitiveIO("infinitives"),
        "participles" => ParticipleIO("participles"),
        "verbaladjectives" => VerbalAdjectiveIO("verbal adjectives"),
        ]
    )
    rulesdirs = [
        "uninflected",
        "irregulars",
        "nouns",
        "pronouns",
        "finiteverbs",
        "infinitives",
        "participles",
        "verbaladjectives",
        "adjectives"
    ]
    rulesarr = Rule[]

    for datasrc in dirlist
        for dirname in rulesdirs 
            dir = joinpath(datasrc, "rules-tables", dirname)
            @debug("PROCESSING DIR ", dir)
            cexfiles = glob("*.cex", dir)

            delimitedreader = (iodict[dirname])
            for f in cexfiles
                raw = readlines(f)
                lines = filter(s -> ! isempty(s), raw)
                for i in 2:length(lines)
                    rule = readrulerow(delimitedreader, lines[i], delimiter = delimiter)
                    push!(rulesarr,rule)
                end
            end
        end
    end

    unique(rulesarr)
end

"""Read all stem data from a list of directories into an array of `Stem`s.

$(SIGNATURES)
"""
function stemsarray(kd::Kanones.Dataset)
    stemsarray(kd.dirs)
end

"""Read all stem data from a `Kanones.Dataset` into an array of `Stem`s.

$(SIGNATURES)
"""
function stemsarray(dirlist; delimiter = "|")
    #@info("Getting regular stems for $dirlist")
    iodict = Dict(
        [
        "adjectives" => AdjectiveIO("adjective"),
        "nouns" => NounIO("noun"),
        "pronouns" => PronounIO("pronoun"),
        "uninflected" => UninflectedIO("uninflected"),
        "verbs-simplex" => VerbIO("verb")
        ]
    )
    stemdirs = [
        "adjectives",
        "nouns",
        "pronouns",
        "uninflected",
        "verbs-simplex",
        
    ]

    stemsarr = Stem[]
    for datasrc in dirlist
        @info("Source: $(datasrc)")
        for dirname in stemdirs 
            #@info("Read stems from dir ", dirname)
            dir = joinpath(datasrc, "stems-tables", dirname)
            #@info("dir = ", dir)
            cexfiles = glob("*.cex", dir)
            delimitedreader = (iodict[dirname])
            for f in cexfiles
                raw = readlines(f)
                #@info("reading steam from raw ", raw)
                # Trim lines first:
                lines = filter(s -> ! isempty(s), raw)
                for i in 2:length(lines)
                    stem = readstemrow(delimitedreader, lines[i]; delimiter = delimiter)
                    push!(stemsarr,stem)
                end
            end
        end
    end


    irregiodict = Dict(
        [
        "uninflected" => UninflectedIO("uninflected"),
        "nouns" => IrregularNounIO("noun"),
        "verbs" => IrregularVerbIO("finite verb"),
        "infinitives" => IrregularInfinitiveIO("infinitive"),
        "adjectives" => IrregularAdjectiveIO("adjectives")
        ]
    )
    irregstemdirs = [
        "nouns",
        "verbs",
        "infinitives",
        "adjectives"
    ]
    #@info("Getting irregular stems for $dirlist")
    for datasrc in dirlist
        for dirname in irregstemdirs 
            dir = joinpath(datasrc, "irregular-stems", dirname)
            cexfiles = glob("*.cex", dir)
            delimitedreader = (irregiodict[dirname])
            for f in cexfiles
                raw = readlines(f)
                lines = filter(s -> ! isempty(s), raw)
                for i in 2:length(lines)
                    stem = readstemrow(delimitedreader, lines[i]; delimiter = delimiter)
                    push!(stemsarr,stem)
                end
            end
        end
    end

    unique(stemsarr)
end




