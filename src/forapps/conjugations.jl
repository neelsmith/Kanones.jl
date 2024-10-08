"""Compose a table in markdown format with the conjugation of a a verb
in a given tense, mood and voice.
$(SIGNATURES)
"""
function conjugate_tmv_md(t::GMPTense, m::GMPMood, v::GMPVoice, lex::LexemeUrn, kd::Kanones.FilesDataset)
    tmvforms = filter(f -> gmpTense(f) == t && gmpMood(f) == m && gmpVoice(f) == v, verbforms())
    tokens = map(f -> generate(lex, formurn(f), kd), tmvforms)
    labels = map(v -> join(v, ", "), tokens)
 
    sing = labels[1:3]
    # skip dual
    pl = labels[7:9]
    mdlines = ["| Person | Singular | Plural |",   
    "| --- | --- | --- |"
    ]

    rowlabels = ["first", "second", "third"]
    mtrx = hcat(sing,pl)
    for i in 1:3
        push!(mdlines, "| $(rowlabels[i]) |" * join(mtrx[i,:], " | ") * " |")
    end
    join(mdlines, "\n")
end

"""Compose a table in markdown format
with the conjugation of verb `lex` in a given
tense and voice.
$(SIGNATURES)
"""
function conjugation_md(t::GMPTense, v::GMPVoice, lex::LexemeUrn, kd::Kanones.FilesDataset)
    tenseforms = filter(f -> gmpTense(f) == t && gmpVoice(f) == v, verbforms())
   
 
    mdlines = ["| | Indicative | Subjunctive | Optative |",   
    "| --- | --- | --- | --- |"]
    
    # SINGULAR:
    indic_forms = filter(f -> gmpMood(f) == gmpMood("indicative") && gmpNumber(f) == gmpNumber("singular"), tenseforms)
   

    
    indic_tokens = map(f -> generate(lex, formurn(f), kd), indic_forms)
    indic_labels = map(v -> join(v, ", "), indic_tokens)
   
    

    subj_forms = filter(f -> gmpMood(f) == gmpMood("subjunctive") && gmpNumber(f) == gmpNumber("singular"), tenseforms)
    subj_tokens = map(f -> generate(lex, formurn(f), kd), subj_forms)
    subj_labels = map(v -> join(v, ", "), subj_tokens)
    if isempty(subj_labels)
        subj_labels = ["-","-","-"]
    end

    opt_forms = filter(f -> gmpMood(f) == gmpMood("optative") && gmpNumber(f) == gmpNumber("singular"), tenseforms)
    opt_tokens = map(f -> generate(lex, formurn(f), kd), opt_forms)
    opt_labels = map(v -> join(v, ", "), opt_tokens)
    if isempty(opt_labels)
        opt_labels = ["-","-","-"]
    end
    for i in 1:3
        push!(mdlines, "| **$(personlabeldict[i]) singular** | $(indic_labels[i]) | $(subj_labels[i]) | $(opt_labels[i]) |")
    end

    # PASSIVE:
    indicpl_forms = filter(f -> gmpMood(f) == gmpMood("indicative") && gmpNumber(f) == gmpNumber("plural"), tenseforms)
    indicpl_tokens = map(f -> generate(lex, formurn(f), kd), indicpl_forms)
    indicpl_labels = map(v -> join(v, ", "), indicpl_tokens)

    subjpl_forms = filter(f -> gmpMood(f) == gmpMood("subjunctive") && gmpNumber(f) == gmpNumber("plural"), tenseforms)
    subjpl_tokens = map(f -> generate(lex, formurn(f), kd), subjpl_forms)
    subjpl_labels = map(v -> join(v, ", "), subjpl_tokens)
    if isempty(subjpl_labels)
        subjpl_labels = ["-","-","-"]
    end

    optpl_forms = filter(f -> gmpMood(f) == gmpMood("optative") && gmpNumber(f) == gmpNumber("plural"), tenseforms)
    optpl_tokens = map(f -> generate(lex, formurn(f), kd), optpl_forms)
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
function imperativeconjugation_md(t::GMPTense, v::GMPVoice, lex::LexemeUrn, kd::Kanones.FilesDataset)
    mdlines = ["| | Singular | Plural|",   
    "| --- | --- | --- |"]
    imptvforms = filter(f -> f isa GMFFiniteVerb && gmpMood(f) == gmpMood("imperative"), allforms())

    singforms = filter(f -> gmpNumber(f) == gmpNumber(1) && gmpTense(f) == t && gmpVoice(f) == v,imptvforms)
    generatedsing = []
    for f in singforms
        frmstring = join(generate(lex, formurn(f), kd),", ")
        push!(generatedsing, frmstring)
    end

    
    plforms = filter(f -> gmpNumber(f) == gmpNumber("plural") && gmpTense(f) == t && gmpVoice(f) == v,imptvforms)
    generatedpl = []
    for f in plforms
        frmstring = join(generate(lex, formurn(f), kd),", ")
        push!(generatedpl,frmstring)
    end
    
     

    #pllabels = plforms .|> label

    for i in 1:2
        push!(mdlines, "| **$(personlabeldict[i + 1])** | $(generatedsing[i]) | $(generatedpl[i])  |")
    end
    join(mdlines,"\n")
end

#=
"""Compose markdown display for proof reading future sytem of verb `lex`.
$(SIGNATURES)
"""
function prooffuture(lex::LexemeUrn, kds::T) where {T <: Kanones.Dataset}

    futfinites = [
        "## Future tense",
        "*Active*",
        conjugation_md(gmpTense("future"), gmpVoice("active"), lex, kds),
        "*Middle*",
        conjugation_md(gmpTense("future"), gmpVoice("middle"), lex, kds),"*Passive*", 
        conjugation_md(gmpTense("future"), gmpVoice("passive"), lex, kds),
    ]

    futinf_act = GMFInfinitive(gmpTense("future"), gmpVoice("active"))
    futinf_actforms = generate(lex, formurn(futinf_act), kds)
    futinf_acttoken = isempty(futinf_actforms) ? "" : futinf_actforms[1]
    
    futinf_mdl = GMFInfinitive(gmpTense("future"), gmpVoice("middle"))
    futinf_mdlforms = generate(lex, formurn(futinf_mdl), kds)
    futinf_mdltoken = isempty(futinf_mdlforms) ? "" : futinf_mdlforms[1]
    
    futinf_pass = GMFInfinitive(gmpTense("future"), gmpVoice("passive"))
    futinf_passforms = generate(lex, formurn(futinf_pass), kds)
    futinf_passtoken = isempty(futinf_passforms) ? "" : futinf_passforms[1]

    actptcpl = participleslashline(lex, gmpTense("future"), gmpVoice("active"), kds)
    midptcpl = participleslashline(lex, gmpTense("future"), gmpVoice("middle"), kds)
    passptcpl = participleslashline(lex, gmpTense("future"), gmpVoice("passive"), kds)

    
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



"""Compose markdown display for proof reading present sytem of verb `lex`.
$(SIGNATURES)
"""
function proofpresent(lex::LexemeUrn, kds::T) where {T <: Kanones.Dataset}

    presfinites = [
        "## Present tense",
        "*Active*", 
        conjugation_md(gmpTense("present"), gmpVoice("active"), lex, kds),
        "*Middle/passive*",  
        conjugation_md(gmpTense("present"), gmpVoice("passive"), lex, kds),
        "### Imperative",
        "*Active*",
        imperativeconjugation_md(gmpTense("present"), gmpVoice("active"), lex, kds),
        "*Middle/passive*", 
        imperativeconjugation_md(gmpTense("present"), gmpVoice("passive"), lex, kds)
    ]
    
    vadj = GMFVerbalAdjective(
    gmpGender("neuter"), gmpCase("nominative"), gmpNumber(1))
    vadjforms = generate(lex, formurn(vadj), kds)
    vadjtoken = isempty(vadjforms) ? ""  : vadjforms[1]

    inf_act = GMFInfinitive(
        gmpTense("present"), gmpVoice("active")
    )
    inf_actforms = generate(lex, formurn(inf_act), kds)
    inf_acttoken = isempty(inf_actforms) ? ""  : inf_actforms[1]

    inf_pass = GMFInfinitive(
        gmpTense("present"), gmpVoice("passive")
    )
    inf_passforms = generate(lex, formurn(inf_pass), kds)
    inf_passtoken = isempty(inf_passforms) ? ""  : inf_passforms[1]

    actptcpl = participleslashline(lex, gmpTense("present"), gmpVoice("active"), kds)

    mpptcpl = participleslashline(lex, gmpTense("present"), gmpVoice("middle"), kds)


    nominals = [
        "- **Active participle**: $(actptcpl)",
        "- **Middle/passive participle**: $(mpptcpl)",

        "- **Active infinitive**: $(inf_acttoken)",
        "- **Passive infinitive**: $(inf_passtoken)",
 
        "- **Verbal adjective**: $(vadjtoken)"
    ]
    
    imperfect = [
        "## Imperfect",
        "*Active*", 
        conjugation_md(gmpTense("imperfect"), gmpVoice("active"), lex, kds),
        "*Middle/passive*",
        conjugation_md(gmpTense("imperfect"), gmpVoice("passive"), lex, kds)
    ]
    

    
    
    join(presfinites,"\n\n") * "\n\n" * join(nominals,"\n") * "\n\n" * join(imperfect,"\n\n")
    
end

"""Compose markdown display for proof reading aorist sytem of verb `lex`.
$(SIGNATURES)
"""
function proofaorist(lex::LexemeUrn, kds::T) where {T <: Kanones.Dataset}
    finites = [
        "## Aorist tense",
        "*Active voice*",
        conjugation_md(gmpTense("aorist"), gmpVoice("active"), lex, kds),
        "*Middle voice*",
        conjugation_md(gmpTense("aorist"), gmpVoice("middle"), lex, kds),
        "*Passive voice*",
        conjugation_md(gmpTense("aorist"), gmpVoice("passive"), lex, kds),
        "### Imperative",
        "*Active voice*",
        imperativeconjugation_md(gmpTense("aorist"), gmpVoice("active"), lex, kds),
        "*Middle voice*",
        imperativeconjugation_md(gmpTense("aorist"), gmpVoice("middle"), lex, kds),
        "*Passive voice*",
        imperativeconjugation_md(gmpTense("aorist"), gmpVoice("passive"), lex, kds),
    ]

    inf_act = GMFInfinitive(gmpTense("aorist"), gmpVoice("active"))
    inf_actforms = generate(lex, formurn(inf_act), kds)
    infacttoken = isempty(inf_actforms) ? "" : inf_actforms[1]

    inf_mdl = GMFInfinitive(gmpTense("aorist"), gmpVoice("middle"))
    inf_mdlforms = generate(lex, formurn(inf_mdl), kds)
    infmdltoken = isempty(inf_mdlforms) ? "" : inf_mdlforms[1]

    inf_pass = GMFInfinitive(gmpTense("aorist"), gmpVoice("passive"))
    inf_passforms = generate(lex, formurn(inf_pass), kds)
    infpasstoken =  isempty(inf_passforms) ? "" : inf_passforms[1]

    actptcpl = participleslashline(lex, gmpTense("aorist"), gmpVoice("active"), kds)
    midptcpl = participleslashline(lex, gmpTense("aorist"), gmpVoice("middle"), kds)
    passptcpl = participleslashline(lex, gmpTense("aorist"), gmpVoice("passive"), kds)


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



"""Compose markdown display for proof reading perfect sytem of verb `lex`.
$(SIGNATURES)
"""
function proofperfect(lex::LexemeUrn, kds::T) where {T <: Kanones.Dataset}
    finites = [
        "## Perfect system",
        "### Perfect tense",
        "*Active voice*",
        conjugation_md(gmpTense("perfect"), gmpVoice("active"), lex, kds),
        "*Middle and passive voices*",
        conjugation_md(gmpTense("perfect"), gmpVoice("passive"), lex, kds)
    ]

    actptcpl = participleslashline(lex, gmpTense("perfect"), gmpVoice("active"), kds)
    mpptcpl = participleslashline(lex, gmpTense("perfect"), gmpVoice("middle"), kds)


    inf_act = GMFInfinitive(gmpTense("perfect"), gmpVoice("active"))
    inf_actforms = generate(lex, formurn(inf_act), kds)
    infacttoken = isempty(inf_actforms) ? "" : inf_actforms[1]

    nominals = [
        "- **active infinitive**: $(infacttoken)",
        "- **active participle**: $(actptcpl)",
        "- **middle & passive participle**: $(mpptcpl)"
    ]
    
    plupft = [
        "### Pluperfect tense",
        "*Active voice*",
        conjugation_md(gmpTense("pluperfect"), gmpVoice("active"), lex, kds),
        "*Middle and passive voices*",
        conjugation_md(gmpTense("pluperfect"), gmpVoice("passive"), lex, kds)
    ]
        
    join(finites,"\n\n") * "\n\n" * join(nominals,"\n") * "\n\n" * join(plupft, "\n\n")
end
=#


function conjugationheader(lex::LexemeUrn, kds::T; note = nothing) where {T <: Kanones.Dataset}

    pia1s = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("present"), gmpMood("indicative"), gmpVoice("active"))
    headerforms = generate(lex, formurn(pia1s), kds)
    if isempty(headerforms) 
        pim1s = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("present"), gmpMood("indicative"), gmpVoice("middle"))
        headerforms = generate(lex, formurn(pim1s), kds)
    end
    hdrlines =
    isempty(headerforms) ? ["Conjugation of $(lex)"]  :     ["# Complete conjugation of $(headerforms[1])"]
   
    
    if note == :blockquote
       push!(hdrlines, "> In the conjugation tables, a dash `-` indicates that a form does not exist in that combination of tense, mood and voice.\n\n> Empty cells indicate forms that are poorly attested, or unattested forms such as active voice forms of deponent verbs.")

    elseif note == :note
        push!(hdrlines, "!!! note \"Empty cells\"\n\n    In the conjugation tables, a dash `-` indicates that a form does not exist in that combination of tense, mood and voice. Empty cells indicate forms that are poorly attested, or unattested forms such as active voice forms of deponent verbs.")
    end
    hdr = join(hdrlines,"\n\n")
    hdr
end
