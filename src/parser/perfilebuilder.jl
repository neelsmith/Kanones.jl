"""Compute all possible forms for rules and stems in `kd`, and write
results to delimited-text files in `targetdir`.
$(SIGNATURES)
"""
function writecsv(kd::Kanones.FilesDataset, targetdir; msgchunk = 50, threshhold = 10000, delimiter = ",")
    #analysis_lines(td) |> StringParser
    @info("Parsing all possible forms in dataset", kd)
    rules = rulesarray(kd)
    stems = stemsarray(kd) 

    writecsv(rules, stems, targetdir, msgchunk = msgchunk, threshhold = threshhold, delimiter = delimiter)
    
end



function writecsv(rules::Vector{Rule}, stems::Vector{Stem}, targetdir; msgchunk = 50, threshhold = 10000, delimiter = ",")
    @info("Write all analyses for rules/stems", length(rules), length(stems))



    analyses = []
    filecount = 0
    totalforms = 0
    
    @debug("Enumerated $(length(stems)) stems")
    for (i, stem) in enumerate(stems)
        
        @debug("$(i) Generating for stem", stem)
        if isnothing(stem)
            throw(DomainError("No stem at index $(i)"))
        end
        append!(analyses, buildparseable(stem, rules, delimiter = delimiter))

        if length(analyses) >= threshhold
            filecount = filecount + 1
            f = joinpath(targetdir, "parses$(filecount).csv")
            open(f, "w") do io
                write(f, join(analyses, "\n") * "\n")
            end
            totalforms = totalforms + length(analyses)
            analyses = []
        end
        if i % msgchunk == 0
            @info("Stem $(i) ($(stem)). $(totalforms) forms written to $(filecount) files so far.")
        end
    end
    f = joinpath(targetdir, "parses$(filecount).csv")
    @info("$(f) (complete)")
    open(f, "w") do io
        write(f, join(analyses, "\n"))
    end
    totalforms = totalforms + length(analyses)
    @info("Done: wrote $(totalforms) forms in $(filecount) files.")
end

function writecsvbytype(kd::Kanones.FilesDataset, targetdir; msgchunk = 50, threshhold = 10000, delimiter = ",")
    @info("Breaking out all verbal data in kd by inflection class.")
    verbrules = filter(rulesarray(kd)) do r
        typeof(r) <: Kanones.KanonesVerbalRule
    end
    infclasses = map(r -> inflectionClass(r), verbrules) |> unique

    for inflclass in infclasses
        @info("Writing data for class ", inflclass)
        outfile = joinpath(targetdir, string(inflclass))
        @info("Putting stuff in " , outfile)
        writecsv(kd, inflclass, targetdir, msgchunk = msgchunk, threshhold = threshhold, delimiter = delimiter)
    end
    @info("Done.")
    
end


function writecsv(kd::Kanones.FilesDataset, infclass, targetdir; msgchunk = 50, threshhold = 10000, delimiter = ",")
    
    rules = filter(rulesarray(kd)) do r
       inflectionClass(r) == infclass
    end
    stems = filter(stemsarray(kd)) do s
        inflectionClass(s) == infclass
     end
     writecsv(rules, stems, targetdir, msgchunk = msgchunk, threshhold = threshhold, delimiter = delimiter)
end

function buildparses(f, delimitedreader, rules::Vector{Rule}; delimiter = ",")

    stemlist = regularstemfile(f, delimitedreader)


    generated = []
    for stem in stemlist
        rulematches = filter(r -> inflectionClass(r) == inflectionClass(stem), rules)
        @info("Generating $(length(rulematches)) forms for $(stemstring(stem)) (class: $(inflectionClass(stem)))")
        for (i, rule) in enumerate(rulematches)
            if i % 1000 == 0
                @info("rule $(i) for $(stemstring(stem))...")
            end
            token = generate(stem, rule)
            @debug("Generated/rule", token, rule)
            @debug(syllabify(knormal(token), literaryGreek()))
            raw = ""
            if buildfromrule(rule)
                raw = join(
                    [knormal(token), lexeme(stem), Kanones.formurn(rule), urn(stem), urn(rule)], delimiter
                    )
            else
                raw = join(
                    [knormal(token), lexeme(stem), Kanones.formurn(stem),  urn(stem),  urn(rule)],
                    delimiter)
            end
            push!(generated, raw)
        end
    end
    generated
end