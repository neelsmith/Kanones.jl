
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
            throw(ArgumentError("No inflectional rules found."))

        elseif isempty(stemsarray(dirlist))
            throw(ArgumentError("No lexicon of stems found."))
        
        # elseif ## if no urn registry ...
        # need to enforce referential integrity of data
        # with registry
        
        else
            new(dirlist, ortho)
        end   
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
        "uninflected" => UninflectedParser("uninflected"),
        "irregulars" => IrregularRuleParser("irregulars"),
        "nouns" => NounIO("noun"),
        "pronouns" => PronounParser("noun"),
        "adjectives" => AdjectiveIO("adjectives"),
        "finiteverbs" => VerbParser("verb"),
        "infinitives" => InfinitiveRuleParser("infinitives"),
        "participles" => ParticipleRuleParser("participles"),
        "verbaladjectives" => VerbalAdjectiveRuleParser("verbal adjectives"),
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
    @info("Getting regular stems for $dirlist")
    iodict = Dict(
        [
        "adjectives" => AdjectiveIO("adjective"),
        "nouns" => NounIO("noun"),
        "pronouns" => PronounParser("pronoun"),
        "uninflected" => UninflectedParser("uninflected"),
        "verbs-simplex" => VerbParser("verb")
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
        for dirname in stemdirs 
            dir = joinpath(datasrc, "stems-tables", dirname)
            cexfiles = glob("*.cex", dir)
            delimitedreader = (iodict[dirname])
            for f in cexfiles
                raw = readlines(f)
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
        "uninflected" => UninflectedParser("uninflected"),
        "nouns" => IrregularNounIO("noun"),
        "verbs" => IrregularVerbParser("finite verb"),
        "infinitives" => IrregularInfinitiveParser("infinitive")
        ]
    )
    irregstemdirs = [
        "nouns",
        "verbs",
        "infinitives"
    ]
    @info("Getting irregular stems for $dirlist")
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




