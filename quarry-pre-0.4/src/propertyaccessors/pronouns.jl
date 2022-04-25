# Forms:

function gmpGender(pronoun::GMFPronoun)    
    pronoun.pgender
end

function gmpCase(pronoun::GMFPronoun)    
    pronoun.pcase
end

function gmpNumber(pronoun::GMFPronoun)    
    pronoun.pnumber
end

# Stem

function gmpGender(pronoun::PronounStem)    
    pronoun.pgender
end

function gmpCase(pronoun::PronounStem)    
    pronoun.pcase
end

function gmpNumber(pronoun::PronounStem)    
    pronoun.pnumber
end