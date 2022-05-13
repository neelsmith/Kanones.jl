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

"""True if rule requires third principal part.
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


"""True if rule requires fifth principal part.
$(SIGNATURES)
"""
function pp5(rule::R) where {R <: KanonesVerbalRule}
    (gmpVoice(rule) == gmpVoice("middle")  || gmpVoice(rule) == gmpVoice("passive") ) &&
    (gmpTense(rule) == gmpTense("perfect") ||
    gmpTense(rule) == gmpTense("pluperfect") ||
    gmpTense(rule) == gmpTense("futureperfect"))
end


"""True if rule requires sixth principal part.
$(SIGNATURES)
"""
function pp6(rule::R) where {R <: KanonesVerbalRule}
    gmpVoice(rule) == gmpVoice("passive") &&
    (gmpTense(rule) == gmpTense("aorist") ||
    gmpTense(rule) == gmpTense("future"))
end


"""Compose regular verb base for fourth
principal part.
$(SIGNATURES)
"""
function kappabase(stem::Stem; ortho = literaryGreek())
    k = strcat(stemstring(stem), "κ", ortho)
end

"""Compose regular verb base for second or third
principal part.
$(SIGNATURES)
"""
function sigmabase(stem::Stem; ortho = literaryGreek())
    @info("Cat $(stemstring(stem)) and `σ`")
    s = stemstring(stem)
    strcat(s,"σ", ortho)
    #=
    if endswith(s, r"κ|γ|χ")    
        replace(s,  r"κ|γ|χ$" => "ξ")
        
    elseif endswith(s, r"π|β|φ")
        replace(s,   r"π|β|φ$" => "ψ")

    else
        s * "σ"
    end
    =#
end


"""Compose regular verb base for sixth
principal part.
$(SIGNATURES)
"""
function thetabase(stem::Stem; ortho = literaryGreek())
    s = stemstring(stem)
    strcat(s,"θ", ortho)
    #=
    if endswith(s, r"κ|γ|χ")    
        replace(s,  r"κ|γ|χ$" => "χ")
        
    elseif endswith(s, r"π|β|φ")
        replace(s,   r"π|β|φ$" => "φ")

    else
        s
    end
    =#
end

"""Compose base stem of `stem` for principalpart required by `rule`.
$(SIGNATURES)
"""
function ppbase(stem::VerbStem, rule::R; ortho = literaryGreek()) where {R <: KanonesVerbalRule}
    if pp2(rule) || pp3(rule)
        sigmabase(stem, ortho = ortho)
    elseif pp4(rule)
        kappabase(stem, ortho = ortho)
    elseif pp6(rule)
        thetabase(stem, ortho = ortho)
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

    if takesreduplication(greekForm(rule))
        extended = reduplicate(extended, ortho)
    end

    if rule isa FiniteVerbRule && takesaugment(greekForm(rule))
       extended = augment(extended, ortho)
    end
    extended
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
