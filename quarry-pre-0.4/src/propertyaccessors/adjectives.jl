# Forms:

function gmpGender(adj::GMFAdjective)    
    adj.adjgender
end

function gmpCase(adj::GMFAdjective)    
    adj.adjcase
end

function gmpNumber(adj::GMFAdjective)    
    adj.adjnumber
end


function gmpDegree(adj::GMFAdjective)    
    adj.adjdegree
end


# Irregular stems

function gmpGender(adj::IrregularAdjectiveStem)    
    adj.adjgender
end

function gmpCase(adj::IrregularAdjectiveStem)    
    adj.adjcase
end

function gmpNumber(adj::IrregularAdjectiveStem)    
    adj.adjnumber
end

function gmpDegree(adj::IrregularAdjectiveStem)    
    adj.adjdegree
end



# Rules

function gmpGender(adj::AdjectiveRule)    
    adj.agender
end

function gmpCase(adj::AdjectiveRule)    
    adj.acase
end

function gmpNumber(adj::AdjectiveRule)    
    adj.anumber
end

function gmpDegree(adj::AdjectiveRule)    
    adj.adegree
end