
function writecsv(kd::Kanones.FilesDataset, targetdir, chunksize = 50; delimiter = ",")
    #analysis_lines(td) |> StringParser
    @info("Parsing all possible forms in dataset", kd)
    analyses = []
    filecount = 0
    rules = rulesarray(kd)
    stems = stemsarray(kd) 
    for (i, stem) in enumerate(stems)
        if i % chunksize == 0
            filecount = filecount + 1
            f = joinpath(targetdir, "parses$(filecount).csv")
            @info("At $(i) ($(stem)): writing $(length(analyses)) forms.")
            open(f, "w") do io
                write(f, join(analyses, "\n"))
            end
            if isempty(analyses)
                throw(DomainError("Failed on every single stem in sequence ending with $(i)"))
            end
            analyses = []
        end
        append!(analyses, buildparseable(stem, rules, delimiter = delimiter))
    end
    f = joinpath(targetdir, "parses$(i).csv")
    @info("$(f) (through $(stem))")
    open(f, "w") do io
        write(f, join(analyses, "\n"))
    end
    @info("Done.")
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