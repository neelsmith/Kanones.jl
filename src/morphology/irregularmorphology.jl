"""Compose a `GreekMorphologicalForm` for irregular form from FST representation of analytical data.

$(SIGNATURES)
"""
function irregularfromfst(fstdata::AbstractString)
    # Parse fstdata
    # based on irregular type
    irregrulere = r"<([^<]+)>"  
    matchedup = collect(eachmatch(irregrulere, fstdata))

    if matchedup[1].captures[1] == "irregularnoun"
        Kanones.irregularnounfromfst(fstdata)
        
    elseif matchedup[1].captures[1] == "irregularfiniteverb"
        Kanones.irregularverbfromfst(fstdata)
       
    elseif matchedup[1].captures[1] == "irregularinfinitive"     
        GMFInfinitive(
            gmpTense(matchedup[2].captures[1]),
            gmpVoice(matchedup[3].captures[1])
        )

    else
        @warn string("Unrecognized irregular type: ", matchedup[1].captures)
    end
end
