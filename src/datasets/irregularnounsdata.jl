"A record for a single irregular noun stem."
struct IrregularNounStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    gender
    gcase
    gnumber
    #inflectionclass
end



#=
function formurn(irregstem::IrregularNounStem)
    numdict = labeldict(numberpairs)
    genderdict = labeldict(genderpairs)
    casedict = labeldict(casepairs)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, NOUN,"0",numdict[irregstem.gnumber],"000",genderdict[irregstem.gender],casedict[irregstem.gcase],"00"))
end
=#

"""Compose FormUrn for an irregular noun stem.

$(SIGNATURES)

For irregulars, all form information is in the stem entry, so we need 
a function to create form urns directory from this.
"""
function abbrformurn(irregstem::IrregularNounStem)
    numdict = labeldict(numberpairs)
    genderdict = labeldict(genderpairs)
    casedict = labeldict(casepairs)
    # PosPNTMVGCDCat
    FormUrn(string("morphforms.", NOUN,"0",numdict[irregstem.gnumber],"000",genderdict[irregstem.gender],casedict[irregstem.gcase],"00"))
end


"""
Read one row of a stems table for noun tokens and create a `NounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::IrregularNounIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)

    # Example:
    #irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun
    # 1. irregnoun.irregn23069a|
    # 2. ls.n23069|
    # 3. γυνή|
    # 4. feminine
    # 5. nominative
    # 6. singular
    # 7. irregularnoun
    if length(parts) < 7
        msg = "Too few parts in $delimited."
        @warn msg
        throw(new(ArgumentError(msg)))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    g = parts[4]
    c = parts[5]
    n = parts[6]
    inflclass = parts[7]

    IrregularNounStem(stemid,lexid,stem,g,c,n)#,inflclass)
end
