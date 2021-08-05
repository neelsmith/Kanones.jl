"""Inflectional rule for infinitive verb form.

$(SIGNATURES)
"""
struct InfinitiveRule <: Rule
    ruleid::Kanones.AbbreviatedUrn
    stemclass
    ending
    tense
    voice
end



"""Read one row of a rules table for infinitives and create an `InfinitiveRule`.

$(SIGNATURES)
"""
function readrulerow(usp::InfinitiveRuleParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 5
        msg = "Invalid syntax for finite verb rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = Kanones.RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        t = parts[4]
        v = parts[5]

        InfinitiveRule(ruleid, inflclass, ending,t,v)
    end

    # Rule|StemClass|Ending|Person|Number|Tense|Mood|Voice
end