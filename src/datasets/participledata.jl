"""Inflectional rule for participial form.

$(SIGNATURES)
"""
struct ParticipleRule <: Rule
    ruleid::Kanones.AbbreviatedUrn
    inflectionclass
    ending
    ptense
    pvoice
    pgender
    pcase
    pnumber
end




"""Read one row of a rules table for infinitives and create an `InfinitiveRule`.

$(SIGNATURES)
"""
function readrulerow(usp::ParticipleIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 5
        msg = "Invalid syntax for finite verb rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        t = parts[4]
        v = parts[5]
        g = parts[6]
        c = parts[7]
        n = parts[8]

        ParticipleRule(ruleid, inflclass, ending,t,v,g,c,n)
    end

    # Rule|StemClass|Ending|Person|Number|Tense|Mood|Voice
end