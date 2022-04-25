# Forms:
function gmpTense(inf::GMFInfinitive)    
    inf.tense
end

function gmpVoice(inf::GMFInfinitive)    
    inf.voice
end


# Irregular stem

function gmpTense(inf::IrregularInfinitiveStem)    
    inf.tense
end

function gmpVoice(inf::IrregularInfinitiveStem)    
    inf.voice
end



# Rules
function gmpTense(inf::InfinitiveRule)    
    inf.tense
end

function gmpVoice(inf::InfinitiveRule)    
    inf.voice
end