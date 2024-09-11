"""Compose markdown summarizing non-finite forms of the given verb in
a single tense system.
$(SIGNATURES)
"""
function nonfinite_summary_md(lexu::LexemeUrn, kd::Kanones.FilesDataset, verbsystem)
    if verbsystem == :present
        nonfinite_present_md(lexu, kd)
    elseif verbsystem == :future
        nonfinite_future_md(lexu, kd)
    elseif verbsystem == :aorist
        nonfinite_aorist_md(lexu, kd)
    elseif verbsystem == :perfect
        nonfinite_perfect_md(lexu, kd)
    else
        throw(ArgumentError("nonfinite_summary_md: value of `verbsystem` must be one of :present, :future, :aorist or :perfect."))
    end
end


"""Compose markdown summarizing non-finite forms of the given verb in
the present system.
$(SIGNATURES)
"""
function nonfinite_present_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)
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
    inf_mdl = GMFInfinitive(
        gmpTense("present"), gmpVoice("middle")
    )
    inf_passforms = generate(lexu, formurn(inf_pass), kd)
    inf_mdlforms =  generate(lexu, formurn(inf_mdl), kd)
    actptcpl = participleslashline(lexu, gmpTense("present"), gmpVoice("active"), kd)   
    mpptcpl = participleslashline(lexu, gmpTense("present"), gmpVoice("middle"), kd)
    psvptcpl = participleslashline(lexu, gmpTense("present"), gmpVoice("passive"), kd)
    
    mdlines = if  isempty(inf_actforms) && isempty(inf_mdlforms) # assume passive deponent
        passinf = isempty(inf_passforms) ? "?" : inf_passforms[1]

        vadj = isempty(vadjforms) ? "?" : vadjforms[1]
        [ "- **passive infinitive**: $(passinf)",
        "- **passive participle**: $(psvptcpl)",
        "- **verbal adjective**: $(vadj)",
        ""
        ]
    elseif isempty(inf_actforms) # assume deponent
    [
        "- **middle & passive infinitive**: $(inf_passforms[1])",
        "- **middle & passive participle**: $(mpptcpl)",
        "- **verbal adjective**: $(vadjforms[1])",
        ""
    ]
    else
    [
        "- **active infinitive**: $(inf_actforms[1])",
        "- **middle & passive infinitive**: $(inf_passforms[1])",
        "- **active participle**: $(actptcpl)",
        "- **middle & passive participle**: $(mpptcpl)",
        "- **verbal adjective**: $(vadjforms[1])",
        ""
    ]
    end

    join(mdlines, "\n")
end

"""Compose markdown summarizing non-finite forms of the given verb in
the future tense.
$(SIGNATURES)
"""
function nonfinite_future_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)
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
    mdlines = if isempty(inf_actforms) # assume deponent

        infmdl = isempty(inf_mdlforms) ? "?" : inf_mdlforms[1]

        infpass = isempty(inf_passforms) ? "?" : inf_passforms[1]
    [
        "- **middle infinitive**: $(infmdl)",
        "- **passive infinitive**: $(infpass)",
        "- **middle participle**: $(midptcpl)",
        "- **passive participle**: $(passptcpl)"
    ]
    else
    [
        "- **active infinitive**: $(inf_actforms[1])",
        "- **middle infinitive**: $(inf_mdlforms[1])",
        "- **passive infinitive**: $(inf_passforms[1])",
        "- **active participle**: $(actptcpl)",
        "- **middle participle**: $(midptcpl)",
        "- **passive participle**: $(passptcpl)"
    ]
    end
    join(mdlines,"\n")
end

"""Compose markdown summarizing non-finite forms of the given verb in
the perfect system.
$(SIGNATURES)
"""
function nonfinite_perfect_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)

    actptcpl = participleslashline(lexu, gmpTense("perfect"), gmpVoice("active"), kd)
    mpptcpl = participleslashline(lexu, gmpTense("perfect"), gmpVoice("middle"), kd)
    inf_act = GMFInfinitive(
        gmpTense("perfect"), gmpVoice("active")
    )
    inf_actforms = generate(lexu, formurn(inf_act), kd)

    md = if isempty(inf_actforms)
    [
        "- **middle & passive participle**: $(mpptcpl)",
        "",
    ]
    else
    [
        "- **active infinitive**: $(inf_actforms[1])",
        "- **active participle**: $(actptcpl)",
        "- **middle & passive participle**: $(mpptcpl)",
        "",
    ]
    end
    join(md, "\n")
end


"""Compose markdown summarizing non-finite forms of the given verb in
the aorist tense.
$(SIGNATURES)
"""
function nonfinite_aorist_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)

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
    infpass = isempty(inf_passforms) ?  "?" : inf_passforms[1]
    
    actptcpl = participleslashline(lexu, gmpTense("aorist"), gmpVoice("active"), kd)
    midptcpl = participleslashline(lexu, gmpTense("aorist"), gmpVoice("middle"), kd)
    passptcpl = participleslashline(lexu, gmpTense("aorist"), gmpVoice("passive"), kd)


    
    md = if  isempty(inf_actforms) && isempty(inf_mdlforms) # assume passive deponent
        [
        "- **passive infinitive**: $(infpass)",
        "- **passive participle**: $(passptcpl)"
        ]

    elseif isempty(inf_actforms)
    [
        "- **middle infinitive**: $(inf_mdlforms[1])",
        "- **passive infinitive**: $(inf_passforms[1])",

        "- **middle participle**: $(midptcpl)",
        "- **passive participle**: $(passptcpl)"
    ]
    else
    [
        "- **active infinitive**: $(inf_actforms[1])",
        "- **middle infinitive**: $(inf_mdlforms[1])",
        "- **passive infinitive**: $(inf_passforms[1])",
        "- **active participle**: $(actptcpl)",
        "- **middle participle**: $(midptcpl)",
        "- **passive participle**: $(passptcpl)"
    ]
    end
    join(md, "\n")
end