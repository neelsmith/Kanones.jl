"""Compose a string with masculine, feminine, neuter nominative singular of a given particple for `lexeme`.
$(SIGNATURES)
"""
function participleslashline(
    lex::LexemeUrn,  
    tense::GMPTense, voice::GMPVoice, 
    kd::Kanones.FilesDataset;
    examplecase = gmpCase("nominative")
    )::String

    formslist = filter(f -> f isa GMFParticiple && gmpTense(f) == tense && gmpVoice(f) == voice && gmpNumber(f) == gmpNumber(1) && gmpCase(f) == examplecase, allforms())

    generated = map(f -> generate(lex, formurn(f), kd),  formslist)
    join(map(v -> isempty(v) ? "" : v[1], generated), ", ")
end


"""Compose markdown for declension of all participles of a verb identified
by LexemeUrn.
$(SIGNATURES)
"""
function participle_declension_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)::String
     sections = [
        presptcpls_md(lexu, kd),
        futureptcpls_md(lexu,kd),
        aoristptcpls_md(lexu,kd),
        perfectptcpls_md(lexu,kd),
    ]
    join(sections, "\n\n")
end



"""Compose markdown for declension of perfect participles of a verb identified
by LexemeUrn.
$(SIGNATURES)
"""
function perfectptcpls_md(lex::LexemeUrn, kd::Kanones.FilesDataset)::String
    actv = ptcplforms(lex, gmpTense("perfect"), gmpVoice("active"), kd)
    mdl =  ptcplforms(lex, gmpTense("perfect"), gmpVoice("middle"), kd)
    
    mdoutput = [
       
        "## Perfect tense","",
        "**Active voice**","",
        formatptcplforms(actv), "",
        "**Middle/passive voices (identical forms)**","",
        formatptcplforms(mdl),
        
    ]

    join(mdoutput, "\n")
end



"""Compose markdown for declension of present participles of a verb identified
by LexemeUrn.
$(SIGNATURES)
"""
function presptcpls_md(lex::LexemeUrn, kd::Kanones.FilesDataset)::String
    actv = ptcplforms(lex, gmpTense("present"), gmpVoice("active"), kd)
    mdl =  ptcplforms(lex, gmpTense("present"), gmpVoice("middle"), kd)
    mdoutput = [
       
        "## Present tense","",
        "**Active voice**","",
        formatptcplforms(actv), "",
        "**Middle/passive voices (identical forms)**","",
        formatptcplforms(mdl)
    ]

    join(mdoutput, "\n")
end



"""Compose markdown for declension of aorist participles of a verb identified
by LexemeUrn.
$(SIGNATURES)
"""
function aoristptcpls_md(lex::LexemeUrn, kd::Kanones.FilesDataset)::String
    actv = ptcplforms(lex, gmpTense("aorist"), gmpVoice("active"), kd)
    mdl =  ptcplforms(lex, gmpTense("aorist"), gmpVoice("middle"), kd)
    psv =  ptcplforms(lex, gmpTense("aorist"), gmpVoice("passive"), kd)
    mdoutput = [
       
        "## Aorist tense","",
        "**Active voice**","",
        formatptcplforms(actv), "",
        "**Middle voice**","",
        formatptcplforms(mdl),"",
        "**Passive voice**","",
        formatptcplforms(psv),""
    ]

    join(mdoutput, "\n")
end



"""Compose markdown for declension of future participles of a verb identified
by LexemeUrn.
$(SIGNATURES)
"""
function futureptcpls_md(lex::LexemeUrn, kd::Kanones.FilesDataset)::String
    actv = ptcplforms(lex, gmpTense("future"), gmpVoice("active"), kd)
    mdl =  ptcplforms(lex, gmpTense("future"), gmpVoice("middle"), kd)
    psv =  ptcplforms(lex, gmpTense("future"), gmpVoice("passive"), kd)
    mdoutput = [
       
        "## Future tense","",
        "**Active voice**","",
        formatptcplforms(actv), "",
        "**Middle voice**","",
        formatptcplforms(mdl), "",
        "**Passive voice**","",
        formatptcplforms(psv),""
    ]
    join(mdoutput, "\n")
end


"""Compose a list of all forms of a participle in a given tense and voice.
$(SIGNATURES)
"""
function ptcplforms(lex::LexemeUrn, 
    tense::GMPTense, voice::GMPVoice, 
    kd::Kanones.FilesDataset)
    
    tensevoiceforms = filter(f -> tense == gmpTense(f) && voice == gmpVoice(f), participleforms())
    tokens = map(f -> generate(lex, formurn(f), kd), tensevoiceforms)
    map(v -> v[1], filter(t -> !isempty(t), tokens))
end


"""Format as a Markdown table a list of participle forms giving a full declension of a given tense and voice.
$(SIGNATURES)
"""
function formatptcplforms(formslist::Vector{String})::String
    labels = ["nominative", "genitive", "dative", "accusative"]
    caselist = map(l -> gmpCase(l), labels)

    lines = [
        "| | Masculine | Feminine | Neuter |", 
        "| --- | --- | --- | --- |",
        "| *singular* |  |  |  |"
    ]
    msing = formslist[1:4]
    mpl = formslist[5:8]
    fsing = formslist[9:12]
    fpl = formslist[13:16]
    nsing = formslist[17:20]
    npl = formslist[21:24]
    sing = hcat(msing, fsing, nsing)
    plural = hcat(mpl, fpl, npl)

    for (i,caselabel) in enumerate(labels)
        row = string("| $(caselabel) | ", join(sing[i,:], " | ") ,  " |")
        push!(lines, row)
    end

    push!(lines, "| *plural* |  |  |  |")
    for (i,caselabel) in enumerate(labels)
        row = string("| $(caselabel) | ", join(plural[i,:], " | ") ,  " |")
        push!(lines, row)
    end

    join(lines, "\n")
end

"""Compose markdown table with a declension of a participle in a single tense-voice.

$(SIGNATURES)
"""
function ptcpldeclension_md(
    lex::LexemeUrn, 
    tense::GMPTense, voice::GMPVoice, 
    kd::Kanones.FilesDataset)
    stemmatches = filter(s -> lexeme(s) == lex, stemsarray(kd))
    if isempty(stemmatches)
        throw(DomainError("No stems found for lexeme $(lex)"))
    elseif length(stemmatches) != 1
        @warn("More than one stem found for $(lex): using first stem.")
    end
    ptcplforms(lex, tense, voice, kd) |> formatptcplforms
end
