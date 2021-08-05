"""Compose FST representation of a single `InfinitiveRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.InfinitiveRule, ortho::T) where {T <: GreekOrthography}
    string("<", rule.stemclass,"><infinitive>", 
    rmaccents(rule.ending, ortho),  
    "<", rule.tense, ">",
    "<", rule.voice, ">",
    string("<u>", fstsafe(rule.ruleid), "</u>")
    )
    #$=verbclass$  <infin>  [#stemchars#]* $tense$ $voice$ <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>
end