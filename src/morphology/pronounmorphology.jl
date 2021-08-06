"""Nouns have gender, case and number."""
struct PronounForm <: MorphologicalForm
    pgender::Int64
    genderlabel::AbstractString    
    pcase::Int64
    caselabel::AbstractString    
    pnumber::Int64
    numberlabel::AbstractString        
end

"""Create a `PronounForm` from a string value.

$(SIGNATURES)
"""
function pronounform(code::AbstractString)
    morphchars = split(code, "")
    ngender = parse(Int64, morphchars[7])
    ncase = parse(Int64, morphchars[8])
    nnumber = parse(Int64, morphchars[3])
    genderdict = valuedict(genderpairs)
    casedict = valuedict(casepairs)
    numberdict = valuedict(numberpairs)
    PronounForm(
        ngender, genderdict[ngender],
        ncase, casedict[ncase],
        nnumber, numberdict[nnumber]
    )
end
 # PosPNTMVGCDCat



"""Compose a PronounForm for a noun form from FST representation of analytical data.

$(SIGNATURES)
"""
function pronounfromfst(fstdata)
    # Example:
    # <feminine><accusative><singular>
    #@warn("Parse FST noun " * fstdata)
    nounrulere = r"<([^<]+)><([^<]+)><([^<]+)>"  
    matchedup = collect(eachmatch(nounrulere, fstdata))
    
    if isempty(matchedup)
        @warn("pronounfromfst: unable to parse FST analysis \"" * fstdata * "\"")
        nothing
    else
        # E.g.,
        # 1="feminine", 2="accusative", 3="singular")

        (g,c,n) = matchedup[1].captures
        
        genderdict = labeldict(genderpairs)
        casedict = labeldict(casepairs)
        numberdict = labeldict(numberpairs)
        nounform = PronounForm(genderdict[g], g,
        casedict[c], c,
        numberdict[n], n)
    end
end



"""Compose a `FormUrn` for a `PronounForm`.

$(SIGNATURES)
"""
function formurn(pronounform::PronounForm)
    FormUrn(string("morphforms.", PRONOUN,"0",pronounform.pnumber,"000",pronounform.pgender,pronounform.pcase,"00"))
end
 # PosPNTMVGCDCat