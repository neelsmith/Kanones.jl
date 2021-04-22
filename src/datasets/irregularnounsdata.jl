"""
Read one row of a stems table for noun tokens and create a `NounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::IrregularNounParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)

    # 1. irregnoun.irregn23069a|
    # 2. ls.n23069|
    # 3. γυνή|
    # 4. feminine
    # EXTRA |nominative|singular

    stemid = Kanones.StemUrn(parts[1])
    lexid = Kanones.LexemeUrn(parts[2])
    # Need to rm accents first!
    stem = nfkc(parts[3])
    gender = parts[4]

    NounStem(stemid,lexid,stem,gender,"irregularnoun","irregularaccent")

end




"""Implementation of reading one row of a rules table for uninflected tokens.

$(SIGNATURES) 
"""
function readrulerow(usp::IrregularNounParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 6
        msg = "Invalid syntax for noun rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        # irregnoun.irregn23069a|ls.n23069|γυνή|feminine|nominative|singular
        ruleid = Kanones.RuleUrn(parts[1])
        inflclass = "irregularnoun"
        ending = ""
        g = parts[4]
        c = parts[5]
        n = parts[6]
 
        NounRule(ruleid, inflclass, ending, g,c,n)
    end
    
end
