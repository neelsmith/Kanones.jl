

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



function md_synopsis(lex::LexemeUrn, ds::Kanones.Dataset, p::GMPPerson, n::GMPNumber)
    label = [
        "present indicative",
        "imperfect indicative",
        "present subjunctive",
        "present optative",

        "future indicative",
        "future optative",

        "aorist indicative",
        "aorist subjunctive",
        "aorist optative",


        "perfect indicative",
        "pluperfect indicative"
    ]
    lines = ["|  | active | middle | passive |",
    "| ---  | --- | --- | --- |"
    ]
    formslist = synopsis(lex, ds, p, n)

    factor = 0
    for (i,f) in enumerate(label)
        triple = 3 * factor
        ln = "| $(f) | $(formslist[triple + 1]) | $(formslist[triple + 2]) | $(formslist[triple + 3]) |"
        push!(lines, ln)
        println(triple)
        factor = factor + 1
    end

    join(lines,"\n")
end
