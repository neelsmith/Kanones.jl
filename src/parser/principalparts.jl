
"""Create sixth principal part for regular verb type.
$(SIGNATURES)
"""
function part6(s::AbstractString)
end

"""Create principal for regular verb classes.
$(SIGNATURES)
"""
function principalpart(stemstring::AbstractString, tense::GMPTense, voice::GMPVoice, inflclass::String)
    if tense == gmpTense("present") || tense == gmpTense("imperfect")
        stemstring
    elseif tense == gmpTense("aorist")
        voice == gmpVoice("passive") ? part6(stemstring) : part3(stemstring)
    #=
    if inflclass == "numi"
        numipart(stemstring, tense, voice)
    else
        stemstring
    end
    =#
end
end

function numipart(s::AbstractString, tense::GMPTense, voice::GMPVoice)
    
end