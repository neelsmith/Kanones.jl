# Forms:

function gmpGender(vadj::GMFVerbalAdjective)    
    va.adjgender
end

function gmpCase(vadj::GMFVerbalAdjective)    
    va.adjcase
end

function gmpNumber(vadj::GMFVerbalAdjective)    
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