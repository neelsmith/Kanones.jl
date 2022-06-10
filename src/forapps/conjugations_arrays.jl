
function md_conjugation(t::GMPTense, v::GMPVoice, lex::LexemeUrn, ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)


    tenseforms = filter(f -> gmpTense(f) == t && gmpVoice(f) == v, verbforms())
   
 
    mdlines = ["| | Indicative | Subjunctive | Optative |",   
    "| --- | --- | --- | --- |"]
    
    # SINGULAR:
    indic_forms = filter(f -> gmpMood(f) == gmpMood("indicative") && gmpNumber(f) == gmpNumber("singular"), tenseforms)
   

    
    indic_tokens = map(f -> generate(lex, formurn(f), ruleset, stemset, orthography), indic_forms)
 
    indic_labels = map(v -> join(v, ", "), indic_tokens)
   
    

    subj_forms = filter(f -> gmpMood(f) == gmpMood("subjunctive") && gmpNumber(f) == gmpNumber("singular"), tenseforms)
    subj_tokens = map(f -> generate(lex, formurn(f), ruleset, stemset, orthography), subj_forms)
    subj_labels = map(v -> join(v, ", "), subj_tokens)
    if isempty(subj_labels)
        subj_labels = ["-","-","-"]
    end

    opt_forms = filter(f -> gmpMood(f) == gmpMood("optative") && gmpNumber(f) == gmpNumber("singular"), tenseforms)
    opt_tokens = map(f -> generate(lex, formurn(f), ruleset, stemset, orthography), opt_forms)
    opt_labels = map(v -> join(v, ", "), opt_tokens)
    if isempty(opt_labels)
        opt_labels = ["-","-","-"]
    end
    for i in 1:3
        push!(mdlines, "| **$(personlabeldict[i]) singular** | $(indic_labels[i]) | $(subj_labels[i]) | $(opt_labels[i]) |")
    end

    # PASSIVE:
    indicpl_forms = filter(f -> gmpMood(f) == gmpMood("indicative") && gmpNumber(f) == gmpNumber("plural"), tenseforms)
    indicpl_tokens = map(f -> generate(lex, formurn(f), ruleset, stemset, orthography), indicpl_forms)
    indicpl_labels = map(v -> join(v, ", "), indicpl_tokens)

    subjpl_forms = filter(f -> gmpMood(f) == gmpMood("subjunctive") && gmpNumber(f) == gmpNumber("plural"), tenseforms)
    subjpl_tokens = map(f -> generate(lex, formurn(f), ruleset, stemset, orthography), subjpl_forms)
    subjpl_labels = map(v -> join(v, ", "), subjpl_tokens)
    if isempty(subjpl_labels)
        subjpl_labels = ["-","-","-"]
    end

    optpl_forms = filter(f -> gmpMood(f) == gmpMood("optative") && gmpNumber(f) == gmpNumber("plural"), tenseforms)
    optpl_tokens = map(f -> generate(lex, formurn(f), ruleset, stemset, orthography), optpl_forms)
    optpl_labels = map(v -> join(v, ", "), optpl_tokens)
    if isempty(optpl_labels)
        optpl_labels = ["-","-","-"]
    end

    for i in 1:3
        push!(mdlines, "| **$(personlabeldict[i]) plural** | $(indicpl_labels[i]) | $(subjpl_labels[i]) | $(optpl_labels[i]) |")
    end
    join(mdlines, "\n")
    
end



"""Compose markdown table with imperative conjugation of `lex`.
$(SIGNATURES)
"""
function md_imperativeconjugation(t::GMPTense, v::GMPVoice, lex::LexemeUrn, ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)
    mdlines = ["| | Singular | Plural|",   
    "| --- | --- | --- |"]
    imptvforms = filter(f -> f isa GMFFiniteVerb && gmpMood(f) == gmpMood("imperative"), allforms())

    singforms = filter(f -> gmpNumber(f) == gmpNumber(1) && gmpTense(f) == t && gmpVoice(f) == v,imptvforms)
    generatedsing = []
    for f in singforms
        frmstring = join(generate(lex, formurn(f), ruleset, stemset, orthography),", ")
        push!(generatedsing, frmstring)
    end

    
    plforms = filter(f -> gmpNumber(f) == gmpNumber("plural") && gmpTense(f) == t && gmpVoice(f) == v,imptvforms)
    generatedpl = []
    for f in plforms
        frmstring = join(generate(lex, formurn(f), ruleset, stemset, orthography),", ")
        push!(generatedpl,frmstring)
    end
    
     

    #pllabels = plforms .|> label

    for i in 1:2
        push!(mdlines, "| **$(personlabeldict[i + 1])** | $(generatedsing[i]) | $(generatedpl[i])  |")
    end
    join(mdlines,"\n")
end


"""Compose a string with masculine, feminine, neuter nominative singular of a given particple ofr `lexeme`.
$(SIGNATURES)
"""
function participleslashline(
    lex::LexemeUrn,  
    tense::GMPTense, voice::GMPVoice, 
    ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)
    ptcplforms = filter(f -> f isa GMFParticiple && gmpTense(f) == tense && gmpVoice(f) == voice && gmpNumber(f) == gmpNumber(1) && gmpCase(f) == gmpCase(1), allforms())


    generated = map(f -> generate(lex, formurn(f), ruleset, stemset, orthography),  ptcplforms)

    nonempty = filter(s -> ! isempty(s), generated)
    join(map(v -> isempty(v) ? "" : v[1], nonempty), ", ")

end



function proofpresent(lex::LexemeUrn, ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)
   

    presfinites = [
        "## Present tense",
        "*Active*", 
        md_conjugation(gmpTense("present"), gmpVoice("active"), lex, ruleset, stemset, orthography),
        "*Middle/passive*",  
        md_conjugation(gmpTense("present"), gmpVoice("passive"), lex, ruleset, stemset, orthography),
        "### Imperative",
        "*Active*",
        md_imperativeconjugation(gmpTense("present"), gmpVoice("active"), lex, ruleset, stemset, orthography),
        "*Middle/passive*", 
        md_imperativeconjugation(gmpTense("present"), gmpVoice("passive"), lex, ruleset, stemset, orthography)
    ]
    
    vadj = GMFVerbalAdjective(
    gmpGender("neuter"), gmpCase("nominative"), gmpNumber(1))
    vadjforms = generate(lex, formurn(vadj), ruleset, stemset, orthography)
    vadjtoken = isempty(vadjforms) ? ""  : vadjforms[1]

    inf_act = GMFInfinitive(
        gmpTense("present"), gmpVoice("active")
    )
    inf_actforms = generate(lex, formurn(inf_act), ruleset, stemset, orthography)
    inf_acttoken = isempty(inf_actforms) ? ""  : inf_actforms[1]

    inf_pass = GMFInfinitive(
        gmpTense("present"), gmpVoice("passive")
    )
    inf_passforms = generate(lex, formurn(inf_pass), ruleset, stemset, orthography)
    inf_passtoken = isempty(inf_passforms) ? ""  : inf_passforms[1]

    actptcpl = participleslashline(lex, gmpTense("present"), gmpVoice("active"), ruleset, stemset, orthography)

    mpptcpl = participleslashline(lex, gmpTense("present"), gmpVoice("middle"), ruleset, stemset, orthography)


    nominals = [
        "- **Active participle**: $(actptcpl)",
        "- **Middle/passive participle**: $(mpptcpl)",

        "- **Active infinitive**: $(inf_acttoken)",
        "- **Middle/passive infinitive**: $(inf_passtoken)",
 
        "- **Verbal adjective**: $(vadjtoken)"
    ]
    
    imperfect = [
        "## Imperfect",
        "*Active*", 
        md_conjugation(gmpTense("imperfect"), gmpVoice("active"), lex, ruleset, stemset, orthography),
        "*Middle/passive*",
        md_conjugation(gmpTense("imperfect"), gmpVoice("passive"), lex, ruleset, stemset, orthography)
    ]

    
    
    join(presfinites,"\n\n") * "\n\n" * join(nominals,"\n") * "\n\n" * join(imperfect,"\n\n")
end


function prooffuture(lex::LexemeUrn,ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)

    futfinites = [
        "## Future tense",
        "*Active*",
        md_conjugation(gmpTense("future"), gmpVoice("active"), lex, ruleset, stemset, orthography),
        "*Middle*",
        md_conjugation(gmpTense("future"), gmpVoice("middle"), lex, ruleset, stemset, orthography),"*Passive*", 
        md_conjugation(gmpTense("future"), gmpVoice("passive"), lex, ruleset, stemset, orthography),
    ]

    futinf_act = GMFInfinitive(gmpTense("future"), gmpVoice("active"))
    futinf_actforms = generate(lex, formurn(futinf_act), ruleset, stemset, orthography)
    futinf_acttoken = isempty(futinf_actforms) ? "" : futinf_actforms[1]
    
    futinf_mdl = GMFInfinitive(gmpTense("future"), gmpVoice("middle"))
    futinf_mdlforms = generate(lex, formurn(futinf_mdl), ruleset, stemset, orthography)
    futinf_mdltoken = isempty(futinf_mdlforms) ? "" : futinf_mdlforms[1]
    
    futinf_pass = GMFInfinitive(gmpTense("future"), gmpVoice("passive"))
    futinf_passforms = generate(lex, formurn(futinf_pass), ruleset, stemset, orthography)
    futinf_passtoken = isempty(futinf_passforms) ? "" : futinf_passforms[1]

    actptcpl = participleslashline(lex, gmpTense("future"), gmpVoice("active"), ruleset, stemset, orthography)
    midptcpl = participleslashline(lex, gmpTense("future"), gmpVoice("middle"), ruleset, stemset, orthography)
    passptcpl = participleslashline(lex, gmpTense("future"), gmpVoice("passive"), ruleset, stemset, orthography)

    
    futnominal = [
        "- **active infinitive**: $(futinf_acttoken)",
        "- **middle infinitive**: $(futinf_mdltoken)",
        "- **passive infinitive**: $(futinf_passtoken)",
      
        "- **active participle**: $(actptcpl)",
        "- **middle participle**: $(midptcpl)",
        "- **passive participle**: $(passptcpl)"
    ]
    join(futfinites,"\n\n") * "\n\n" * join(futnominal,"\n")
end



function proofaorist(lex::LexemeUrn, ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)
    finites = [
        "## Aorist tense",
        "*Active voice*",
        md_conjugation(gmpTense("aorist"), gmpVoice("active"), lex, ruleset, stemset, orthography),
        "*Middle voice*",
        md_conjugation(gmpTense("aorist"), gmpVoice("middle"), lex, ruleset, stemset, orthography),
        "*Passive voice*",
        md_conjugation(gmpTense("aorist"), gmpVoice("passive"), lex, ruleset, stemset, orthography),
        "### Imperative",
        "*Active voice*",
        md_imperativeconjugation(gmpTense("aorist"), gmpVoice("active"), lex, ruleset, stemset, orthography),
        "*Middle voice*",
        md_imperativeconjugation(gmpTense("aorist"), gmpVoice("middle"), lex, ruleset, stemset, orthography),
        "*Passive voice*",
        md_imperativeconjugation(gmpTense("aorist"), gmpVoice("passive"), lex, ruleset, stemset, orthography),
    ]

    inf_act = GMFInfinitive(gmpTense("aorist"), gmpVoice("active"))
    inf_actforms = generate(lex, formurn(inf_act), ruleset, stemset, orthography)
    infacttoken = isempty(inf_actforms) ? "" : inf_actforms[1]

    inf_mdl = GMFInfinitive(gmpTense("aorist"), gmpVoice("middle"))
    inf_mdlforms = generate(lex, formurn(inf_mdl), ruleset, stemset, orthography)
    infmdltoken = isempty(inf_mdlforms) ? "" : inf_mdlforms[1]

    inf_pass = GMFInfinitive(gmpTense("aorist"), gmpVoice("passive"))
    inf_passforms = generate(lex, formurn(inf_pass), ruleset, stemset, orthography)
    infpasstoken =  isempty(inf_passforms) ? "" : inf_passforms[1]

    actptcpl = participleslashline(lex, gmpTense("aorist"), gmpVoice("active"), ruleset, stemset, orthography)
    midptcpl = participleslashline(lex, gmpTense("aorist"), gmpVoice("middle"), ruleset, stemset, orthography)
    passptcpl = participleslashline(lex, gmpTense("aorist"), gmpVoice("passive"), ruleset, stemset, orthography)


    nominals = [
        "- **active infinitive**: $(infacttoken)",
        "- **middle infinitive**: $(infmdltoken)",
        "- **passive infinitive**: $(infpasstoken)",
        "- **active participle**: $(actptcpl)",
        "- **middle participle**: $(midptcpl)",
        "- **passive participle**: $(passptcpl)"
    ]
       
    join(finites,"\n\n") * "\n\n" *  join(nominals,"\n") * "\n\n"
end


function proofperfect(lex::LexemeUrn, ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)
    finites = [
        "## Perfect system",
        "### Perfect tense",
        "*Active voice*",
        md_conjugation(gmpTense("perfect"), gmpVoice("active"), lex, ruleset, stemset, orthography),
        "*Middle and passive voices*",
        md_conjugation(gmpTense("perfect"), gmpVoice("passive"), lex, ruleset, stemset, orthography)
    ]

    actptcpl = participleslashline(lex, gmpTense("perfect"), gmpVoice("active"), ruleset, stemset, orthography)
    mpptcpl = participleslashline(lex, gmpTense("perfect"), gmpVoice("middle"), ruleset, stemset, orthography)


    inf_act = GMFInfinitive(gmpTense("perfect"), gmpVoice("active"))
    inf_actforms = generate(lex, formurn(inf_act), ruleset, stemset, orthography)
    infacttoken = isempty(inf_actforms) ? "" : inf_actforms[1]

    nominals = [
        "- **active infinitive**: $(infacttoken)",
        "- **active participle**: $(actptcpl)",
        "- **middle & passive participle**: $(mpptcpl)"
    ]
    
    plupft = [
        "### Pluperfect tense",
        "*Active voice*",
        md_conjugation(gmpTense("pluperfect"), gmpVoice("active"), lex, ruleset, stemset, orthography),
        "*Middle and passive voices*",
        md_conjugation(gmpTense("pluperfect"), gmpVoice("passive"), lex, ruleset, stemset, orthography)
    ]
        
    join(finites,"\n\n") * "\n\n" * join(nominals,"\n") * "\n\n" * join(plupft, "\n\n")
end

"""Write complete conjugation of the verb `lex` to a file.
$(SIGNATURES)
"""
function md_proofconjugation(lex::LexemeUrn, kds::T; note = nothing) where {T <: Kanones.Dataset} 
    hdr = conjugationheader(lex, kds, note = note)
    ruleset = filter(r -> verbalrule(r), rulesarray(kds))
    stemset = stemsarray(kds)

    presentsystem = proofpresent(lex, ruleset, stemset, orthography(kds))

    futuresystem = prooffuture(lex,ruleset, stemset, orthography(kds))
        
    aoristsystem = proofaorist(lex,ruleset, stemset, orthography(kds))
    perfectsystem = proofperfect(lex,ruleset, stemset, orthography(kds))

    pieces = [
        hdr,
        presentsystem,
        futuresystem, 
        aoristsystem,
        perfectsystem
    ]

    join(pieces, "\n\n")
end

function mdfile_proofconjugation(lex::LexemeUrn, kds::T, f = "scratch/proofconjugation.md"; note = nothing) where {T <: Kanones.Dataset} 
    md = md_proofconjugation(lex,kds, note = note)
    open(f, "w") do io
        write(io, md)
    end
end
