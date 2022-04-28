
function conjugation()
end

function md_conjugation(t::GMPTense, lex::LexemeUrn, kd::Kanones.Dataset)
    tenseforms = filter(f -> gmpTense(f) == t, verbforms())
   

    mdlines = ["Active voice", "",
    "| | Indicative | Subjunctive | Optative |",   
    "| --- | --- | --- | --- |"]
    
    # SINGULAR:
    indic_forms = filter(f -> gmpMood(f) == gmpMood("indicative") && gmpNumber(f) == gmpNumber("singular") && gmpVoice(f) == gmpVoice("active"), tenseforms)
    indic_tokens = map(f -> generate(lex, formurn(f), kd), indic_forms)
    indic_labels = map(v -> join(v, ", "), indic_tokens)

    subj_forms = filter(f -> gmpMood(f) == gmpMood("subjunctive") && gmpNumber(f) == gmpNumber("singular") && gmpVoice(f) == gmpVoice("active"), tenseforms)
    subj_tokens = map(f -> generate(lex, formurn(f), kd), subj_forms)
    subj_labels = map(v -> join(v, ", "), subj_tokens)


    opt_forms = filter(f -> gmpMood(f) == gmpMood("optative") && gmpNumber(f) == gmpNumber("singular") && gmpVoice(f) == gmpVoice("active"), tenseforms)
    opt_tokens = map(f -> generate(lex, formurn(f), kd), opt_forms)
    opt_labels = map(v -> join(v, ", "), opt_tokens)
    
    for i in 1:3
        push!(mdlines, "| **$(personlabeldict[i]) singular** | $(indic_labels[i]) | $(subj_labels[i]) | $(opt_labels[i]) |")
    end

    # PASSIVE:
    indicpl_forms = filter(f -> gmpMood(f) == gmpMood("indicative") && gmpNumber(f) == gmpNumber("plural") && gmpVoice(f) == gmpVoice("active"), tenseforms)
    indicpl_tokens = map(f -> generate(lex, formurn(f), kd), indicpl_forms)
    indicpl_labels = map(v -> join(v, ", "), indicpl_tokens)

    subjpl_forms = filter(f -> gmpMood(f) == gmpMood("subjunctive") && gmpNumber(f) == gmpNumber("plural") && gmpVoice(f) == gmpVoice("active"), tenseforms)
    subjpl_tokens = map(f -> generate(lex, formurn(f), kd), subjpl_forms)
    subjpl_labels = map(v -> join(v, ", "), subjpl_tokens)


    optpl_forms = filter(f -> gmpMood(f) == gmpMood("optative") && gmpNumber(f) == gmpNumber("plural") && gmpVoice(f) == gmpVoice("active"), tenseforms)
    optpl_tokens = map(f -> generate(lex, formurn(f), kd), optpl_forms)
    optpl_labels = map(v -> join(v, ", "), optpl_tokens)
    
    for i in 1:3
        push!(mdlines, "| **$(personlabeldict[i]) plural** | $(indicpl_labels[i]) | $(subjpl_labels[i]) | $(optpl_labels[i]) |")
    end


    
    join(mdlines, "\n")
    
end