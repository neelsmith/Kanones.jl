
"""Finite verbs have person, number, tense, mood and voice."""
struct FiniteVerbForm <: MorphologicalForm
    vperson::Int64
    personlabel::AbstractString    
    vnumber::Int64
    numberlabel::AbstractString    
    vtense::Int64
    tenselabel::AbstractString   
    vmood::Int64
    moodlabel::AbstractString    
    vvoice::Int64
    voicelabel::AbstractString 
end

"""Create a `NounForm` from a URN."""
function finiteverbform(urn::Cite2Urn)
    nothing
end

"""Compose URN for a `FiniteVerbForm`."""
function urn(noun::FiniteVerbForm)
    nothing
end


"""Compose CEX representation for a `FiniteVerbForm`."""
function cex(noun::FiniteVerbForm)
    nothing
end


"""Compose URN for finite verb form from FST representation of analytical data."""
function finiteverbabbrurn(fstdata)
    nothing
end


function finiteverbscex()
    persondict = valuedict(personpairs)
    personkeys = keys(persondict)  |> collect |> sort 

    
    numberdict = valuedict(numberpairs)
    numberkeys = keys(numberdict)  |> collect |> sort 

    tensedict = valuedict(tensepairs)
    tensekeys = keys(tensedict)  |> collect |> sort 

    mooddict = valuedict(moodpairs)
    moodkeys = keys(mooddict)  |> collect |> sort 

    voicedict = valuedict(voicepairs)
    voicekeys = keys(voicedict)  |> collect |> sort 



    lines = []
    # But don't generate non-existent forms!  
    # Don't want complete permutations. (E.g., imperfect only in indicative!)
    #
    # PosPNTMVGCDCat
    #=
    for num in numberkeys
        for gen in genderkeys
            for cs in casekeys
                u = string(BASE_MORPHOLOGY_URN, NOUN, "0", num, "000", gen, cs, "00")
                label = string("noun: ", genderdict[gen], " ", casedict[cs], " ", numberdict[num])
                cex = string(u, "|", label)
                push!(lines, cex)
            end
        end
    end
    =#
    join(lines, "\n")  


end