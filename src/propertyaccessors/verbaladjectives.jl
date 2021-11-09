# Forms:

function gmpGender(vadj::GMFVerbaAdjective)    
    va.adjgender
end

function gmpCase(vadj::GMFVerbaAdjective)    
    va.adjcase
end

function gmpNumber(vadj::GMFVerbaAdjective)    
    va.adjnumber
end





# Rules

function gmpGender(vadj::VerbalAdjectiveRule)    
    vadj.vagender
end

function gmpCase(vadj::VerbalAdjectiveRule)    
    vadj.vacase
end

function gmpNumber(vadj::VerbalAdjectiveRule)    
    vadj.vanumber
end