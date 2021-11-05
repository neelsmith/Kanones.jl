"""Compose FST representation of a single `InfinitiveRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.InfinitiveRule; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    string("<", rule.inflectionclass,"><infinitive>", 
    rmaccents(rule.ending, ortho),  
    "<", rule.tense, ">",
    "<", rule.voice, ">",
    fstsafe(rule.ruleid)
    )
    #$=verbclass$  <infin>  [#stemchars#]* $tense$ $voice$ <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>
end