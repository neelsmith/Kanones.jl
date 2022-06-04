

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