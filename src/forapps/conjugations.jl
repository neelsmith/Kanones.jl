
function conjugation()
end

function md_conjugation(t::GMPTense, lex::LexemeUrn, kd::Kanones.Dataset)
    tenseforms = filter(f -> gmpTense(f) == t, verbforms())
   

    mdlines = ["Active voice", "",
    "| | Indicative | Subjunctive | Optative |",   
    "| --- | --- | --- | --- |"]
    
    # Indicative singular:
    indic_s = filter(f -> gmpMood(f) == gmpMood("indicative") && gmpNumber(f) == gmpNumber("singular") && gmpVoice(f) == gmpVoice("active"), tenseforms)

    #=
    
    for i in 1:3
        indic = tenseforms[i]
        indicative = CitableParserBuilder.tokens( generate(indic,lex,td))
        rowheader = join([label(lmpPerson(indic)), label(lmpNumber(indic)) ], " ")

        if hassubjunctive(t)
            subj = tenseforms[i + 6]
            subjunctive = CitableParserBuilder.tokens( generate(subj,lex,td))    
            push!(mdlines, "| **$(rowheader)** | $(indicative) | $(subjunctive) | ")
        else
            push!(mdlines, "| **$(rowheader)** | $(indicative) | - | ")
        end
    end


    
    for i in 4:6
        indic = tenseforms[i]
        indicative = CitableParserBuilder.tokens( generate(indic,lex,td))
        rowheader = join([label(lmpPerson(indic)), label(lmpNumber(indic)) ], " ")

        if hassubjunctive(t)
            subj = tenseforms[i + 6]
            subjunctive = CitableParserBuilder.tokens( generate(subj,lex,td))
            push!(mdlines, "| **$(rowheader)** | $(indicative) | $(subjunctive) | ")
        else
            push!(mdlines, "| **$(rowheader)** | $(indicative) | - | ")
        end
    end

    passive_origin = hassubjunctive(t) ?  13 : 7

    
    offset = perfectsystem(t) ? 3 : 6
    if perfectsystem(t)
        push!(mdlines, "Passive voice of $(label(t)): TBA")
    else
        push!(mdlines,"Passive voice")
        push!(mdlines, "")
        push!(mdlines, "| | Indicative | Subjunctive |")
        push!(mdlines, "| --- | --- | --- |")
        for i in passive_origin:passive_origin+2
            ind = tenseforms[i]
            indicative = CitableParserBuilder.tokens( generate(ind,lex,td))
            rowheader = join([label(lmpPerson(ind)), label(lmpNumber(ind)) ], " ")

            if hassubjunctive(t)
                subj = tenseforms[i + offset]
                subjunctive = CitableParserBuilder.tokens( generate(subj,lex,td))
                push!(mdlines, "| **$(rowheader)** | $(indicative) |  $(subjunctive) | ")
            else
                push!(mdlines, "| **$(rowheader)** | $(indicative) |  - | ")
            end
        end
        for i in passive_origin+3:passive_origin+5
            ind = tenseforms[i]
            indicative = CitableParserBuilder.tokens( generate(ind,lex,td))
            rowheader = join([label(lmpPerson(ind)), label(lmpNumber(ind)) ], " ")

            if hassubjunctive(t)
                subj = tenseforms[i + offset]
                subjunctive = CitableParserBuilder.tokens( generate(subj,lex,td))
                push!(mdlines, "| **$(rowheader)** | $(indicative) | $(subjunctive) | ")
            else
                push!(mdlines, "| **$(rowheader)** | $(indicative) |  - | ")
            end
        end
    end
    join(mdlines, "\n")
    =#
end