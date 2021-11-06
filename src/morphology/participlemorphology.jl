
"""Finite verbs have person, number, tense, mood and voice."""
struct ParticipleForm <: MorphologicalForm
    tense::Int64
    #tenselabel::AbstractString  
    voice::Int64
    #voicelabel::AbstractString 
    pgender::Int64
    #genderlabel::AbstractString    
    pcase::Int64
    #caselabel::AbstractString    
    pnumber::Int64
    #numberlabel::AbstractString  
end

"""Participle forms are citable by Cite2Urn"""
CitableTrait(::Type{ParticipleForm}) = CitableByCite2Urn()

"""Compose a label for a `VerbalAdjectiveForm`

$(SIGNATURES)
"""
function label(ptcpl::ParticipleForm)
    gdict = Kanones.genderpairs |> Kanones.valuedict
    cdict = Kanones.casepairs |> Kanones.valuedict
    ndict = Kanones.numberpairs |> Kanones.valuedict
    tdict = Kanones.tensepairs |> Kanones.valuedict
    vdict = Kanones.voicepairs |> Kanones.valuedict
    join([tdict[ptcpl.tense],vdict[ptcpl.voice],gdict[ptcpl.pgender], cdict[ptcpl.pcase], ndict[ptcpl.pnumber]], " ")
end


"""Compose a Cite2Urn for a `ParticipleForm`.

$(SIGNATURES)
"""
function urn(ptcpl::ParticipleForm)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, PARTICIPLE,"0",ptcpl.pnumber,ptcpl.tense, "0",ptcpl.voice,ptcpl.pgender,ptcpl.pcase,"00"))
end


"""Create a `ParticipleForm` from a string value.

$(SIGNATURES)
"""
function participleform(code::AbstractString)
    morphchars = split(code, "")
    pgender = parse(Int64, morphchars[7])
    pcase = parse(Int64, morphchars[8])
    pnumber = parse(Int64, morphchars[3])
    ptense = parse(Int64, morphchars[4])
    pvoice = parse(Int64, morphchars[6])
    ParticipleForm(
        ptense,
        pvoice,
        pgender,
        pcase,
        pnumber
    )
end

"""Create a `ParticipleForm` from a `Cite2Urn`.

$(SIGNATURES)
"""
function participleform(urn::Cite2Urn)
    participleform(objectcomponent(urn))
end

"""Create a `ParticipleForm` from a `FormUrn`.

$(SIGNATURES)
"""
function participleform(f::FormUrn)
    participleform(f.objectid)
end


"""Create a `ParticipleForm` from an `Analysis`.

$(SIGNATURES)
"""
function participleform(a::Analysis)
    participleform(a.form)
end



"""Compose URN for infinitive verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function participlefromfst(fstdata)
    # Example rule string:

    # Extract TVGCN from a string like the example:
    ptcprulere = r"<([^<]+)><([^<]+)><([^<]+)><([^<]+)><([^<]+)>"
    matchedup = collect(eachmatch(ptcprulere, fstdata))

    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\" as verb form.")
        nothing
    else
        (t, v, g, c, n) = matchedup[1].captures
        tensedict = labeldict(tensepairs)
        voicedict = labeldict(voicepairs)
        genderdict = labeldict(genderpairs)
        casedict = labeldict(casepairs)
        numberdict = labeldict(numberpairs)
        ParticipleForm(
        tensedict[t],# t,
        voicedict[v], #v,
        genderdict[g], #g,
        casedict[c], #c,
        numberdict[n] #, n
        )
    end
end

"""Compose a `FormUrn` for an `InfinitiveForm`.

$(SIGNATURES)
"""
function formurn(ptcpl::ParticipleForm)
    #PosPNTMVGCDCat
    FormUrn(string("morphforms.", PARTICIPLE, 
    "0",ptcpl.pnumber, ptcpl.tense, "0", ptcpl.voice, 
    ptcpl.pgender, ptcpl.pcase, "00"))
end




"""Compose an abbreviated URN for a rule from a `NounRule`.

$(SIGNATURES)
"""
function ruleurn(rule::ParticipleRule)
    numdict = labeldict(numberpairs)
    casedict = labeldict(casepairs)
    genderdict = labeldict(genderpairs)
    tensedict = labeldict(tensepairs)
    voicedict = labeldict(voicepairs)

    # PosPNTMVGCDCat
    RuleUrn(string("morphforms.", PARTICIPLE,"0",numdict[rule.pnumber],tensedict[rule.ptense], "0",voicedict[rule.pvoice],genderdict[rule.pgender],casedict[rule.pcase],"00"))
end