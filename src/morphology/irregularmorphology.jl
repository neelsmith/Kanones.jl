
"""Compose a `GreekMorphologicalForm` for irregular form from FST representation of analytical data.

$(SIGNATURES)
"""
function irregularfromfst(fstdata::AbstractString)
    # Parse fstdata
    # based on irregular type, construct urn for form
    irregrulere = r"<([^<]+)>"  
    matchedup = collect(eachmatch(irregrulere, fstdata))

    if matchedup[1].captures[1] == "irregularnoun"
        # Looks like:
        #<u>irregnoun.irregn23069a</u><u>lsj.n23069</u>γυνη<irregular><irregularnoun><feminine><nominative><singular><div><irregularnoun><irregular><u>litgreek.irregular1</u>
        # 2-4 are gcn
        ngender =  matchedup[2].captures[1]
        ncase = matchedup[3].captures[1]
        nnumber = matchedup[4].captures[1]

        numdict = labeldict(numberpairs)
        casedict = labeldict(casepairs)
        genderdict = labeldict(genderpairs)

        NounForm(
            genderdict[ngender],# ngender,
            casedict[ncase], #ncase,
            numdict[nnumber] #, nnumber
        )
        
    elseif matchedup[1].captures[1] == "irregularfiniteverb"
        # Looks like
        # <u>irregverb.irregverbnn26447af</u><u>lsj.n26447</u>δοιντο<irregular><irregularfiniteverb><third><plural><aorist><subjunctive><middle>
        # 2-6 are pntmv
        prsn =  matchedup[2].captures[1]
        nmbr = matchedup[3].captures[1]
        tns = matchedup[4].captures[1]
        md = matchedup[5].captures[1]
        vc = matchedup[6].captures[1]

        persondict = labeldict(personpairs)
        numberdict = labeldict(numberpairs)
        tensedict = labeldict(tensepairs)
        
        
        
        GMFFiniteVerb(
            persondict[prsn], #prsn,
            numberdict[nmbr],# nmbr,
            tensedict[tns], #tns,
            gmpMood(md), #md,
            gmpVoice(vc) #, vc
        )

    elseif matchedup[1].captures[1] == "irregularinfinitive"
        tns = matchedup[2].captures[1]
        vc = matchedup[3].captures[1]
        tensedict = labeldict(tensepairs)
       
        
        InfinitiveForm(
            tensedict[tns],
            gmpVoice(vc)
        )
    else
        @warn string("Unrecognized irregular type: ", matchedup[1].captures)
    end
end
