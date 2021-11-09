# Forms:

function gmpGender(noun::GMFNoun)    
    noun.ngender
end

function gmpCase(noun::GMFNoun)    
    noun.ncase
end

function gmpNumber(noun::GMFNoun)    
    noun.nnumber
end

#gender::GMPGender

function gmpGender(noun::NounStem)    
    noun.gender
end