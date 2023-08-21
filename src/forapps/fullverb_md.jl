"""Compose markdown for full conjugation of verb identified
by LexemeUrn.
$(SIGNATURES)
"""
function verb_conjugation_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)
    sections = [   
        presentsystem_md(lexu, kd),
        futuretense_md(lexu, kd),
        aoristtense_md(lexu, kd),
        perfectsystem_md(lexu, kd),
    ]
    join(sections, "\n\n")
end


"""Compose markdown for conjugation in the perfect system of the verb identified by LexemeUrn.
$(SIGNATURES)
"""
function perfectsystem_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)

   mdoutput = [
        "## Perfect system","",
        "### Perfect tense","",
        "*Active voice*:","",
        conjugation_md(gmpTense("perfect"), gmpVoice("active"),lexu,kd),
        "",
        "*Middle and passive voices* (identical forms):","",
        conjugation_md(gmpTense("perfect"), gmpVoice("passive"),lexu,kd),
        "",
        nonfinite_perfect_md(lexu, kd),

        "### Pluperfect tense","",
        "*Active voice*:","",
        conjugation_md(gmpTense("pluperfect"), gmpVoice("active"),lexu,kd),
        "",
        "*Middle and passive voices* (identical forms):","",
        conjugation_md(gmpTense("pluperfect"), gmpVoice("passive"), lexu,kd)

    ]

    join(mdoutput, "\n")
end

"""Compose markdown for conjugation in the aorist tense of the verb identified by LexemeUrn.
$(SIGNATURES)
"""
function aoristtense_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)
    mdoutput = [
    "## Aorist tense","",
    "*Active voice*:","",
    conjugation_md(gmpTense("aorist"), gmpVoice("active"), lexu, kd),
    "",
    "*Middle voice*:","",
    conjugation_md(gmpTense("aorist"), gmpVoice("middle"), lexu, kd),
    "",
    "*Passive voice*:","",
    conjugation_md(gmpTense("aorist"), gmpVoice("passive"), lexu, kd),
    "",

    "### Imperative","",
    "*Active voice*:","",
    imperativeconjugation_md(gmpTense("aorist"), gmpVoice("active"), lexu, kd),
    "",
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


"""Compose markdown for conjugation in the future tense of the verb identified by LexemeUrn.
$(SIGNATURES)
"""
function futuretense_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)
    mdoutput = [
    "## Future tense","",
    "*Active voice*:","",
    conjugation_md(gmpTense("future"), gmpVoice("active"), lexu, kd),
    "",

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


"""Compose markdown for conjugation in the present system of the verb identified by LexemeUrn.
$(SIGNATURES)
"""
function presentsystem_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)
    vadj = GMFVerbalAdjective(
        gmpGender("neuter"), gmpCase("nominative"), gmpNumber(1)
    )
    vadjforms = generate(lexu, formurn(vadj), kd) 
    inf_act = GMFInfinitive(
        gmpTense("present"), gmpVoice("active")
    )
    inf_actforms = generate(lexu, formurn(inf_act), kd)
    inf_pass = GMFInfinitive(
        gmpTense("present"), gmpVoice("passive")
    )
    inf_passforms = generate(lexu, formurn(inf_pass), kd)
    actptcpl = participleslashline(lexu, gmpTense("present"), gmpVoice("active"), kd)   
    mpptcpl = participleslashline(lexu, gmpTense("present"), gmpVoice("middle"), kd)
    
    mdoutput = [
    "## Present system","",
    "### Present tense","",

    "*Active voice*:","",
    conjugation_md(gmpTense("present"), gmpVoice("active"), lexu, kd),
    "",

    "*Middle and passive voices* (identical forms):","",
    conjugation_md(gmpTense("present"), gmpVoice("passive"), lexu, kd),
    "",

    "### Imperative","",
    "*Active voice*:","",
    imperativeconjugation_md(gmpTense("present"), gmpVoice("active"), lexu, kd),
    "",

    "*Middle and passive voices* (identical forms):","",
    imperativeconjugation_md(gmpTense("present"), gmpVoice("passive"), lexu, kd),
    "",

    nonfinite_present_md(lexu, kd),


    "### Imperfect tense","",
    "*Active voice*:","",
    conjugation_md(gmpTense("imperfect"), gmpVoice("active"), lexu, kd),
    "",

    "*Middle and passive voices* (identical forms):","",
    conjugation_md(gmpTense("imperfect"), gmpVoice("passive"), lexu, kd),
    ]

    join(mdoutput, "\n")
end