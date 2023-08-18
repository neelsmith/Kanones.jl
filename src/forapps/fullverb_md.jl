function verb_conjugation_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)
    sections = [   
        presentsystem_md(lexu, kd),
        futuretense_md(lexu, kd),
        aoristtense_md(lexu, kd),
        perfectsystem_md(lexu, kd),
    ]
    join(sections, "\n\n")
end

function perfectsystem_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)

    actptcpl = participleslashline(lexu, gmpTense("perfect"), gmpVoice("active"), kd)
    mpptcpl = participleslashline(lexu, gmpTense("perfect"), gmpVoice("middle"), kd)
    inf_act = GMFInfinitive(
        gmpTense("perfect"), gmpVoice("active")
    )
    inf_actforms = generate(lexu, formurn(inf_act), kd)

   mdoutput = [
        "## Perfect system","",
        "### Perfect tense","",
        "*Active voice*:","",
        md_conjugation(gmpTense("perfect"), gmpVoice("active"),lexu,kd),
        "",
        "*Middle and passive voices* (identical forms):","",
        md_conjugation(gmpTense("perfect"), gmpVoice("passive"),lexu,kd),
        "",
        "- **active infinitive**: $(inf_actforms[1])",
        "- **active participle**: $(actptcpl)",
        "- **middle & passive participle**: $(mpptcpl)",
        "",
        "### Pluperfect tense","",
        "*Active voice*:","",
        md_conjugation(gmpTense("pluperfect"), gmpVoice("active"),lexu,kd),
        "",
        "*Middle and passive voices* (identical forms):","",
        md_conjugation(gmpTense("pluperfect"), gmpVoice("passive"), lexu,kd)

    ]

    join(mdoutput, "\n")
end


function aoristtense_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)

    inf_act = GMFInfinitive(
        gmpTense("aorist"), gmpVoice("active")
    )
    inf_actforms = generate(lexu, formurn(inf_act), kd)
    inf_mdl = GMFInfinitive(
        gmpTense("aorist"), gmpVoice("middle")
    )
    inf_mdlforms = generate(lexu, formurn(inf_mdl), kd)
    inf_pass = GMFInfinitive(
        gmpTense("aorist"), gmpVoice("passive")
    )
    inf_passforms = generate(lexu, formurn(inf_pass), kd)
    actptcpl = participleslashline(lexu, gmpTense("aorist"), gmpVoice("active"), kd)
    midptcpl = participleslashline(lexu, gmpTense("aorist"), gmpVoice("middle"), kd)
    passptcpl = participleslashline(lexu, gmpTense("aorist"), gmpVoice("passive"), kd)

    mdoutput = [
    "## Aorist tense","",
    "*Active voice*:","",
    md_conjugation(gmpTense("aorist"), gmpVoice("active"), lexu, kd),
    "",
    "*Middle voice*:","",
    md_conjugation(gmpTense("aorist"), gmpVoice("middle"), lexu, kd),
    "",
    "*Passive voice*:","",
    md_conjugation(gmpTense("aorist"), gmpVoice("passive"), lexu, kd),
    "",


    "### Imperative","",
    "*Active voice*:","",
    md_imperativeconjugation(gmpTense("aorist"), gmpVoice("active"), lexu, kd),
    "",
    "*Middle voice*:","",
    md_imperativeconjugation(gmpTense("aorist"), gmpVoice("middle"), lexu, kd),
    "*Passive voice*:","",
    md_imperativeconjugation(gmpTense("aorist"), gmpVoice("passive"), lexu, kd),
    "",
    "- **active infinitive**: $(inf_actforms[1])",
    "- **middle infinitive**: $(inf_mdlforms[1])",
    "- **passive infinitive**: $(inf_passforms[1])",
    "- **active participle**: $(actptcpl)",
    "- **middle participle**: $(midptcpl)",
    "- **passive participle**: $(passptcpl)"
    ]

    join(mdoutput, "\n")
end

function futuretense_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)
    inf_act = GMFInfinitive(
        gmpTense("future"), gmpVoice("active")
    )
    inf_actforms = generate(lexu, formurn(inf_act), kd)
    inf_mdl = GMFInfinitive(
        gmpTense("future"), gmpVoice("middle")
    )
    inf_mdlforms = generate(lexu, formurn(inf_mdl), kd)
    inf_pass = GMFInfinitive(
        gmpTense("future"), gmpVoice("passive")
    )
    inf_passforms = generate(lexu, formurn(inf_pass), kd)
    actptcpl = participleslashline(lexu, gmpTense("future"), gmpVoice("active"), kd)
    midptcpl = participleslashline(lexu, gmpTense("future"), gmpVoice("middle"), kd)
    passptcpl = participleslashline(lexu, gmpTense("future"), gmpVoice("passive"), kd)


    mdoutput = [
    "## Future tense","",
    "*Active voice*:","",
    md_conjugation(gmpTense("future"), gmpVoice("active"), lexu, kd),

    "*Middle voice*:","",
    md_conjugation(gmpTense("future"), gmpVoice("middle"), lexu, kd),

    "*Passive voice*:","",
    md_conjugation(gmpTense("future"), gmpVoice("passive"), lexu, kd),
    "",

    "- **active infinitive**: $(inf_actforms[1])",
    "- **middle infinitive**: $(inf_mdlforms[1])",
    "- **passive infinitive**: $(inf_passforms[1])",
    "- **active participle**: $(actptcpl)",
    "- **middle participle**: $(midptcpl)",
    "- **passive participle**: $(passptcpl)"
    ]

    join(mdoutput, "\n")
end

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
    md_conjugation(gmpTense("present"), gmpVoice("active"), lexu, kd),
    "",

    "*Middle and passive voices* (identical forms):","",
    md_conjugation(gmpTense("present"), gmpVoice("passive"), lexu, kd),
    "",

    "### Imperative","",
    "*Active voice*:","",
    md_imperativeconjugation(gmpTense("present"), gmpVoice("active"), lexu, kd),
    "",

    "*Middle and passive voices* (identical forms):","",
    md_imperativeconjugation(gmpTense("present"), gmpVoice("passive"), lexu, kd),
    "",
    "- **active infinitive**: $(inf_actforms[1])",
    "- **middle & passive infinitive**: $(inf_passforms[1])",
    "- **active participle**: $(actptcpl)",
    "- **middle & passive participle**: $(mpptcpl)",
    "- **verbal adjective**: $(vadjforms[1])",
    "",


    "### Imperfect tense","",
    "*Active voice*:","",
    md_conjugation(gmpTense("imperfect"), gmpVoice("active"), lexu, kd),
    "",

    "*Middle and passive voices* (identical forms):","",
    md_conjugation(gmpTense("imperfect"), gmpVoice("passive"), lexu, kd),
    ]

    join(mdoutput, "\n")
end