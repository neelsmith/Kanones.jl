
"""Generate verb forms for a given person and number
in the given tense.
$(SIGNATURES)
"""
function synopsis(lex::LexemeUrn, ds::Kanones.Dataset, p::GMPPerson, n::GMPNumber, t::GMPTense)
    moods = [gmpMood("indicative"), gmpMood("subjunctive"), gmpMood("optative")]
    voices = [gmpVoice("active"), gmpVoice("middle"), gmpVoice("passive")]

    results = []
    for m in moods
        for v in voices
            verbform = GMFFiniteVerb(p,n,t,m,v) |> formurn
            push!(results, generate(lex,verbform,ds))
        end
    end
    results
end



"""Generate finite forms of `lex` for a given person and number.
$(SIGNATURES)
"""
function synopsis(lex::LexemeUrn, ds::Kanones.Dataset, p::GMPPerson, n::GMPNumber)
   
    moods = [gmpMood("indicative"), gmpMood("subjunctive"), gmpMood("optative")]
    voices = [gmpVoice("active"), gmpVoice("middle"), gmpVoice("passive")]


    results = []

    t = gmpTense("present")
    m = gmpMood("indicative")
    for v in voices
        verbform = GMFFiniteVerb(p,n,t,m,v) |> formurn
        push!(results, generate(lex,verbform,ds)[1])
    end
    t = gmpTense("imperfect")
    for v in voices
        verbform = GMFFiniteVerb(p,n,t,m,v) |> formurn
        push!(results, generate(lex,verbform,ds)[1])
    end

    t = gmpTense("present")
    for m in  [gmpMood("subjunctive"), gmpMood("optative")]
        for v in voices
            verbform = GMFFiniteVerb(p,n,t,m,v) |> formurn
            push!(results, generate(lex,verbform,ds)[1])
        end
    end

    t = gmpTense("future")
    for m in  [gmpMood("indicative"), gmpMood("optative")]
        for v in voices
            verbform = GMFFiniteVerb(p,n,t,m,v) |> formurn
            forms  = generate(lex,verbform,ds)
            isempty(forms) ? push!(results,"") : push!(results, forms[1])
        end
    end


    t = gmpTense("aorist")
    for m in moods
        for v in voices
            verbform = GMFFiniteVerb(p,n,t,m,v) |> formurn
            push!(results, generate(lex,verbform,ds)[1])
        end
    end



    t = gmpTense("perfect")
    m = gmpMood("indicative")
    for v in voices
        verbform = GMFFiniteVerb(p,n,t,m,v) |> formurn
        push!(results, generate(lex,verbform,ds)[1])
    end
    t = gmpTense("pluperfect")
    for v in voices
        verbform = GMFFiniteVerb(p,n,t,m,v) |> formurn
        push!(results, generate(lex,verbform,ds)[1])
    end
    results
end




"""Format markdown display of synopsis of `lex` for a given person and number.
$(SIGNATURES)
"""
function synopsis_md(lex::LexemeUrn, ds::Kanones.Dataset, p::GMPPerson, n::GMPNumber)
    labellist = [
        "present, indicative",
        "imperfect, indicative",
        "present, subjunctive",
        "present, optative",

        "future, indicative",
        "future, optative",

        "aorist, indicative",
        "aorist, subjunctive",
        "aorist, optative",


        "perfect, indicative",
        "pluperfect, indicative"
    ]
    lemmaform = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense(1), gmpMood(1), gmpVoice(1)) |> formurn
    
    lemma = generate(lex,lemmaform,ds)[1]

    lines = [
        "# Synopsis of $(lemma): $(label(p)) person $(label(n))",
        "",
        "| tense, mood | active | middle | passive |",
        "| ---  | --- | --- | --- |"
    ]
    formslist = synopsis(lex, ds, p, n)

    factor = 0
    for (i,f) in enumerate(labellist)
        triple = 3 * factor
        ln = "| $(f) | $(formslist[triple + 1]) | $(formslist[triple + 2]) | $(formslist[triple + 3]) |"
        push!(lines, ln)
        @debug(triple)
        factor = factor + 1
    end

    join(lines,"\n")
end
