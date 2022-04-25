# Forms:

function gmpTense(ptcpl::GMFParticiple)    
    ptcpl.tense
end

function gmpVoice(ptcpl::GMFParticiple)    
    ptcpl.voice
end

function gmpGender(ptcpl::GMFParticiple)    
    ptcpl.pgender
end

function gmpCase(ptcpl::GMFParticiple)    
    ptcpl.pcase
end

function gmpNumber(ptcpl::GMFParticiple)    
    ptcpl.pnumber
end


# Rules

function gmpTense(ptcpl::ParticipleRule)    
    ptcpl.ptense
end

function gmpVoice(ptcpl::ParticipleRule)    
    ptcpl.pvoice
end

function gmpGender(ptcpl::ParticipleRule)    
    ptcpl.pgender
end

function gmpCase(ptcpl::ParticipleRule)    
    ptcpl.pcase
end

function gmpNumber(ptcpl::ParticipleRule)    
    ptcpl.pnumber
end
