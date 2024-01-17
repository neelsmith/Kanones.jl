"""Compose markdown for full conjugation of verb identified
by LexemeUrn.
$(SIGNATURES)
"""
function full_conjugation_md_deponent(lexu::LexemeUrn, kd::Kanones.FilesDataset)
    sections = [   
        presentsystem_md_deponent(lexu, kd),
        futuretense_md_deponent(lexu, kd),
        aoristtense_md_deponent(lexu, kd),
        perfectsystem_md_deponent(lexu, kd),
    ]
    join(sections, "\n\n")
end

"""Compose markdown for conjugation in the aorist tense of the verb identified by LexemeUrn.
$(SIGNATURES)
"""
function aoristtense_md_deponent(lexu::LexemeUrn, kd::Kanones.FilesDataset)
    mdoutput = [
 
    "*Middle voice*:","",
    conjugation_md(gmpTense("aorist"), gmpVoice("middle"), lexu, kd),
    "",
    "*Passive voice*:","",
    conjugation_md(gmpTense("aorist"), gmpVoice("passive"), lexu, kd),
    "",

    "### Imperative","",

    "*Middle voice*:","",
    imperativeconjugation_md(gmpTense("aorist"), gmpVoice("middle"), lexu, kd),
    "",
    "*Passive voice*:","",
    imperativeconjugation_md(gmpTense("aorist"), gmpVoice("passive"), lexu, kd),
    "",
    nonfinite_aorist_md(lexu, kd),
    ""
    ]

    join(mdoutput, "\n")
end


"""Compose markdown for conjugation in the present system of the verb identified by LexemeUrn.
$(SIGNATURES)
"""
function presentsystem_md_deponent(lexu::LexemeUrn, kd::Kanones.FilesDataset)
    vadj = GMFVerbalAdjective(
        gmpGender("neuter"), gmpCase("nominative"), gmpNumber(1)
    )
    vadjforms = generate(lexu, formurn(vadj), kd) 
  
    
    inf_pass = GMFInfinitive(
        gmpTense("present"), gmpVoice("passive")
    )
    inf_passforms = generate(lexu, formurn(inf_pass), kd)
    actptcpl = participleslashline(lexu, gmpTense("present"), gmpVoice("active"), kd)   
    mpptcpl = participleslashline(lexu, gmpTense("present"), gmpVoice("middle"), kd)
    
    mdoutput = [
    "## Present system","",
    "### Present tense","",

   

    "*Middle and passive voices* (identical forms):","",
    conjugation_md(gmpTense("present"), gmpVoice("passive"), lexu, kd),
    "",

    "### Imperative","",
 
    "*Middle and passive voices* (identical forms):","",
    imperativeconjugation_md(gmpTense("present"), gmpVoice("passive"), lexu, kd),
    "",

    nonfinite_present_md(lexu, kd),


    "### Imperfect tense","",


    "*Middle and passive voices* (identical forms):","",
    conjugation_md(gmpTense("imperfect"), gmpVoice("passive"), lexu, kd),
    ]

    join(mdoutput, "\n")
end

"""Compose markdown for conjugation in the future tense of the verb identified by LexemeUrn.
$(SIGNATURES)
"""
function futuretense_md_deponent(lexu::LexemeUrn, kd::Kanones.FilesDataset)
    mdoutput = [
    "## Future tense","",


    "*Middle voice*:","",
    conjugation_md(gmpTense("future"), gmpVoice("middle"), lexu, kd),
    "",

    "*Passive voice*:","",
    conjugation_md(gmpTense("future"), gmpVoice("passive"), lexu, kd),
    "",
    nonfinite_future_md(lexu, kd),
    "",

    ]

    join(mdoutput, "\n")
end

function conjugation_md_deponent(t::GMPTense, v::GMPVoice, lex::LexemeUrn, ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)

    tenseforms = filter(f -> gmpTense(f) == t && gmpVoice(f) == v, deponentverbforms())
 
 
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
function imperativeconjugation_md_deponent(t::GMPTense, v::GMPVoice, lex::LexemeUrn, ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)
    mdlines = ["| | Singular | Plural|",   
    "| --- | --- | --- |"]
    imptvforms = filter(f -> f isa GMFFiniteVerb && gmpMood(f) == gmpMood("imperative") && gmpVoice(f) != gmpVoice("active"), allforms())

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
function participleslashline_deponent(
    lex::LexemeUrn,  
    tense::GMPTense, voice::GMPVoice, 
    ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)
    ptcplforms = filter(f -> f isa GMFParticiple && gmpVoice(f) != gmpVoice("active") && gmpTense(f) == tense && gmpVoice(f) == voice && gmpNumber(f) == gmpNumber(1) && gmpCase(f) == gmpCase(1), allforms())


    generated = map(f -> generate(lex, formurn(f), ruleset, stemset, orthography),  ptcplforms)

    nonempty = filter(s -> ! isempty(s), generated)
    join(map(v -> isempty(v) ? "" : v[1], nonempty), ", ")

end

"""Compose markdown for conjugation in the perfect system of the verb identified by LexemeUrn.
$(SIGNATURES)
"""
function perfectsystem_md_deponent(lexu::LexemeUrn, kd::Kanones.FilesDataset)

   mdoutput = [
        "## Perfect system","",
        "### Perfect tense","",
  
        "*Middle and passive voices* (identical forms):","",
        conjugation_md(gmpTense("perfect"), gmpVoice("passive"),lexu,kd),
        "",
        nonfinite_perfect_md(lexu, kd),

        "### Pluperfect tense","",
      
        "*Middle and passive voices* (identical forms):","",
        conjugation_md(gmpTense("pluperfect"), gmpVoice("passive"), lexu,kd)

    ]

    join(mdoutput, "\n")
end

#=
function proofpresent_deponent(lex::LexemeUrn, ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)
   

    presfinites = [
        "## Present tense",
 
        "*Middle/passive*",  
        conjugation_md(gmpTense("present"), gmpVoice("passive"), lex, ruleset, stemset, orthography),
        "### Imperative",
        "*Middle/passive*", 
        imperativeconjugation_md(gmpTense("present"), gmpVoice("passive"), lex, ruleset, stemset, orthography)
    ]
    
    vadj = GMFVerbalAdjective(
    gmpGender("neuter"), gmpCase("nominative"), gmpNumber(1))
    vadjforms = generate(lex, formurn(vadj), ruleset, stemset, orthography)
    vadjtoken = isempty(vadjforms) ? ""  : vadjforms[1]

 

    inf_pass = GMFInfinitive(
        gmpTense("present"), gmpVoice("passive")
    )
    inf_passforms = generate(lex, formurn(inf_pass), ruleset, stemset, orthography)
    inf_passtoken = isempty(inf_passforms) ? ""  : inf_passforms[1]

    mpptcpl = participleslashline(lex, gmpTense("present"), gmpVoice("middle"), ruleset, stemset, orthography)


    nominals = [

        "- **Middle/passive participle**: $(mpptcpl)",

        "- **Middle/passive infinitive**: $(inf_passtoken)",
 
        "- **Verbal adjective**: $(vadjtoken)"
    ]
    
    imperfect = [
        "## Imperfect",

        "*Middle/passive*",
        conjugation_md(gmpTense("imperfect"), gmpVoice("passive"), lex, ruleset, stemset, orthography)
    ]

    
    
    join(presfinites,"\n\n") * "\n\n" * join(nominals,"\n") * "\n\n" * join(imperfect,"\n\n")
end


function prooffuture_deponent(lex::LexemeUrn,ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)

    futfinites = [
        "## Future tense",

        "*Middle*",
        conjugation_md(gmpTense("future"), gmpVoice("middle"), lex, ruleset, stemset, orthography),"*Passive*", 
        conjugation_md(gmpTense("future"), gmpVoice("passive"), lex, ruleset, stemset, orthography),
    ]

    
    futinf_mdl = GMFInfinitive(gmpTense("future"), gmpVoice("middle"))
    futinf_mdlforms = generate(lex, formurn(futinf_mdl), ruleset, stemset, orthography)
    futinf_mdltoken = isempty(futinf_mdlforms) ? "" : futinf_mdlforms[1]
    
    futinf_pass = GMFInfinitive(gmpTense("future"), gmpVoice("passive"))
    futinf_passforms = generate(lex, formurn(futinf_pass), ruleset, stemset, orthography)
    futinf_passtoken = isempty(futinf_passforms) ? "" : futinf_passforms[1]


    midptcpl = participleslashline(lex, gmpTense("future"), gmpVoice("middle"), ruleset, stemset, orthography)
    passptcpl = participleslashline(lex, gmpTense("future"), gmpVoice("passive"), ruleset, stemset, orthography)

    
    futnominal = [

        "- **middle infinitive**: $(futinf_mdltoken)",
        "- **passive infinitive**: $(futinf_passtoken)",
      
 
        "- **middle participle**: $(midptcpl)",
        "- **passive participle**: $(passptcpl)"
    ]
    join(futfinites,"\n\n") * "\n\n" * join(futnominal,"\n")
end



function proofaorist_deponent(lex::LexemeUrn, ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)
    finites = [
        "## Aorist tense",

        "*Middle voice*",
        conjugation_md(gmpTense("aorist"), gmpVoice("middle"), lex, ruleset, stemset, orthography),
        "*Passive voice*",
        conjugation_md(gmpTense("aorist"), gmpVoice("passive"), lex, ruleset, stemset, orthography),
        "### Imperative",
    
        "*Middle voice*",
        imperativeconjugation_md(gmpTense("aorist"), gmpVoice("middle"), lex, ruleset, stemset, orthography),
        "*Passive voice*",
        imperativeconjugation_md(gmpTense("aorist"), gmpVoice("passive"), lex, ruleset, stemset, orthography),
    ]

  
    inf_mdl = GMFInfinitive(gmpTense("aorist"), gmpVoice("middle"))
    inf_mdlforms = generate(lex, formurn(inf_mdl), ruleset, stemset, orthography)
    infmdltoken = isempty(inf_mdlforms) ? "" : inf_mdlforms[1]

    inf_pass = GMFInfinitive(gmpTense("aorist"), gmpVoice("passive"))
    inf_passforms = generate(lex, formurn(inf_pass), ruleset, stemset, orthography)
    infpasstoken =  isempty(inf_passforms) ? "" : inf_passforms[1]

    midptcpl = participleslashline(lex, gmpTense("aorist"), gmpVoice("middle"), ruleset, stemset, orthography)
    passptcpl = participleslashline(lex, gmpTense("aorist"), gmpVoice("passive"), ruleset, stemset, orthography)


    nominals = [
  
        "- **middle infinitive**: $(infmdltoken)",
        "- **passive infinitive**: $(infpasstoken)",
  
        "- **middle participle**: $(midptcpl)",
        "- **passive participle**: $(passptcpl)"
    ]
       
    join(finites,"\n\n") * "\n\n" *  join(nominals,"\n") * "\n\n"
end


function proofperfect_deponent(lex::LexemeUrn, ruleset::Vector{Rule}, stemset::Vector{Stem}, orthography::GreekOrthography)
    finites = [
        "## Perfect system",
        "### Perfect tense",

        "*Middle and passive voices*",
        conjugation_md(gmpTense("perfect"), gmpVoice("passive"), lex, ruleset, stemset, orthography)
    ]

    mpptcpl = participleslashline(lex, gmpTense("perfect"), gmpVoice("middle"), ruleset, stemset, orthography)

    nominals = [

        "- **middle & passive participle**: $(mpptcpl)"
    ]
    
    plupft = [
        "### Pluperfect tense",
 
        "*Middle and passive voices*",
        conjugation_md(gmpTense("pluperfect"), gmpVoice("passive"), lex, ruleset, stemset, orthography)
    ]
        
    join(finites,"\n\n") * "\n\n" * join(nominals,"\n") * "\n\n" * join(plupft, "\n\n")
end

"""Write complete conjugation of the verb `lex` to a file.
$(SIGNATURES)
"""
function md_proofconjugation_deponent(lex::LexemeUrn, kds::T; note = nothing) where {T <: Kanones.Dataset} 
    hdr = conjugationheader(lex, kds, note = note)
    ruleset = filter(r -> verbalrule(r), rulesarray(kds))
    stemset = stemsarray(kds)

    presentsystem = proofpresent_deponent(lex, ruleset, stemset, orthography(kds))

    futuresystem = prooffuture_deponent(lex,ruleset, stemset, orthography(kds))
        
    aoristsystem = proofaorist_deponent(lex,ruleset, stemset, orthography(kds))
    perfectsystem = proofperfect_deponent(lex,ruleset, stemset, orthography(kds))

    pieces = [
        hdr,
        presentsystem,
        futuresystem, 
        aoristsystem,
        perfectsystem
    ]

    join(pieces, "\n\n")
end

function mdfile_proofconjugation_deponent(lex::LexemeUrn, kds::T, f = "scratch/proofconjugation.md"; note = nothing) where {T <: Kanones.Dataset} 
    md = md_proofconjugation_deponent(lex,kds, note = note)
    open(f, "w") do io
        write(io, md)
    end
end
=#