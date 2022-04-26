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

# Regular Stem

function gmpGender(noun::NounStem)    
    noun.gender
end

# Irregular stem

function gmpGender(noun::IrregularNounStem)    
    noun.noungender
end

function gmpCase(noun::IrregularNounStem)    
    noun.nouncase
end

function gmpNumber(noun::IrregularNounStem)    
    noun.nounnumber
end



# Rules
function gmpGender(noun::NounRule)    
    noun.ngender
end

function gmpCase(noun::NounRule)    
    noun.ncase
end


function gmpNumber(noun::NounRule)    
    noun.nnumber
end