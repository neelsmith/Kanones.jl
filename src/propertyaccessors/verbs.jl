# Forms:

function gmpTense(verb::GMFFiniteVerb)    
    verb.vtense
end

function gmpMood(verb::GMFFiniteVerb)    
    verb.vmood
end

function gmpVoice(verb::GMFFiniteVerb)    
    verb.vvoice
end
function gmpPerson(verb::GMFFiniteVerb)    
    verb.vperson
end

function gmpNumber(verb::GMFFiniteVerb)    
    verb.vnumber
end


# Irregular stem

function gmpTense(verb::IrregularVerbStem)    
    verb.vtense
end

function gmpMood(verb::IrregularVerbStem)    
    verb.vmood
end

function gmpVoice(verb::IrregularVerbStem)    
    verb.vvoice
end
function gmpPerson(verb::IrregularVerbStem)    
    verb.vperson
end

function gmpNumber(verb::IrregularVerbStem)    
    verb.vnumber
end



# Rules

function gmpTense(verb::FiniteVerbRule)    
    verb.vtense
end

function gmpMood(verb::FiniteVerbRule)    
    verb.vmood
end

function gmpVoice(verb::FiniteVerbRule)    
    verb.vvoice
end
function gmpPerson(verb::FiniteVerbRule)    
    verb.vperson
end

function gmpNumber(verb::FiniteVerbRule)    
    verb.vnumber
end