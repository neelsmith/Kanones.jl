"""True if `inflclass` is a regular verb type that
requires only a single principle part.
$(SIGNATURES)
"""
function regularverbclass(stem::VerbStem)
    inflectionClass(stem) in REGULAR_VERB_CLASSES
end

"""True if rule requires second principal part.
$(SIGNATURES)
"""
function pp2(rule::R) where {R <: KanonesVerbalRule}
    gmpVoice(rule) != gmpVoice("passive") &&
    gmpTense(rule) == gmpTense("future")
end

"""True if rule requires second principal part.
$(SIGNATURES)
"""
function pp3(rule::R) where {R <: KanonesVerbalRule}
    gmpVoice(rule) != gmpVoice("passive") &&
    gmpTense(rule) == gmpTense("aorist")
end

"""True if rule requires fourth principal part.
$(SIGNATURES)
"""
function pp4(rule::R) where {R <: KanonesVerbalRule}
    gmpVoice(rule) == gmpVoice("active") &&
    (gmpTense(rule) == gmpTense("perfect") ||
    gmpTense(rule) == gmpTense("pluperfect") ||
    gmpTense(rule) == gmpTense("futureperfect"))
     
end

"""True if rule requires second principal part.
$(SIGNATURES)
"""
function pp6(rule::R) where {R <: KanonesVerbalRule}
    gmpVoice(rule) == gmpVoice("passive") &&
    (gmpTense(rule) == gmpTense("aorist") ||
    gmpTense(rule) == gmpTense("future"))
end


"""Add augment to `s`.
$(SIGNATURES)
"""
function augment(s::AbstractString; ortho = literaryGreek())
    if s[1] in consonants(ortho)
        PolytonicGreek.nfkc("ἐ" * s)
    else
        @warn("TEMPORAL AUGMENT NOT YET IMPLEMENTED")
        stemstring(s)
    end
end


function reduplicate(s::AbstractString; ortho = literaryGreek())
    if occursin(s[1], vowels(ortho))
        @warn("VOWEL AUGMENT NOT YET IMPLEMENTED")
    else
        replace(s, r"^(.)" => s"\1ε\1")
    end

end

"""Compose regular verb base for fourth
principal part.
$(SIGNATURES)
"""
function kappabase(stem::Stem; ortho = literaryGreek())
    k = stemstring(stem) * "κ"
    reduplicate(k, ortho = ortho)
end

"""Compose regular verb base for second or third
principal part.
$(SIGNATURES)
"""
function sigmabase(stem::Stem; ortho = literaryGreek())
    s = stemstring(stem)
    if endswith(s, r"κ|γ|χ")    
        s * "ξ"
    elseif endswith(s, r"π|β|φ")
        s * "ψ"
    else
        s * "σ"
    end
end



"""Compose base stem of `stem` for principalpart required by `rule`.
$(SIGNATURES)
"""
function ppbase(stem::VerbStem, rule::R; ortho = literaryGreek()) where {R <: KanonesVerbalRule}
    if pp2(rule) || pp3(rule)
        sigmabase(stem, ortho = ortho)
    elseif pp4(rule)
        kappabase(stem, ortho = ortho)
    
    else
        stemstring(stem)
    end
end

"""Compose stem for appropriate principal part of a completely
regular verb.
$(SIGNATURES)
"""
function principalpart(stem::VerbStem, rule::R; ortho = literaryGreek()) where {R <: KanonesVerbalRule}
    extended = ppbase(stem, rule, ortho = ortho)
    @debug("principal part got extended base", extended)

    if rule isa FiniteVerbRule && takesaugment(greekForm(rule))
       augment(extended, ortho = ortho)
    else
        extended
    end
end

"""True if `f` takes augment.
$(SIGNATURES)
"""
function takesaugment(f::GMFFiniteVerb)
    gmpMood(f) == gmpMood("indicative") &&
    (gmpTense(f) == gmpTense("imperfect") || 
    gmpTense(f) == gmpTense("aorist") ||
    gmpTense(f) == gmpTense("pluperfect"))
end

"""True if `f` takes reduplication.
$(SIGNATURES)
"""
function takesreduplication(f::GMFFiniteVerb)
    gmpTense(f) == gmpTense("perfect")  ||
    gmpTense(f) == gmpTense("pluperfect")  
end
