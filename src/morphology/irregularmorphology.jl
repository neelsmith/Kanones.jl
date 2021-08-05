
"""Compose Abbreviated URN for irregular form from FST representation of analytical data.

$(SIGNATURES)
"""
function irregularfromfst(fstdata::AbstractString)
    # Parse fstdata
    # based on irregular type, construct urn for form
    irregrulere = r"<([^<]+)>"  
    matchedup = collect(eachmatch(irregrulere, fstdata))
    #(uninflclass, ruleid) = matchedup[1].captures
    if matchedup[1].captures[1] == "irregularnoun"
        # 2-4 are gcn
        ngender =  matchedup[2].captures[1]
        ncase = matchedup[3].captures[1]
        nnumber = matchedup[4].captures[1]

        numdict = labeldict(numberpairs)
        casedict = labeldict(casepairs)
        genderdict = labeldict(genderpairs)

        NounForm(
            genderdict[ngender], ngender,
            casedict[ncase], ncase,
            numdict[nnumber], nnumber
        )
        # PosPNTMVGCDCat
        #FormUrn(string("morphforms.", NOUN,"0",numdict[nnumber],"000",genderdict[ngender],casedict[ncase],"00"))
        #<u>irregnoun.irregn23069a</u><u>lsj.n23069</u>γυνη<irregular><irregularnoun><feminine><nominative><singular><div><irregularnoun><irregular><u>litgreek.irregular1</u>
    else
        @warn string("Unrecognized irregular type: ", matchedup[1].captures)
    end
end
