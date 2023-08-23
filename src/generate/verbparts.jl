"""True if `stem` is a contract verb.
$(SIGNATURES)
"""
function compoundtype(stem::VerbStem)
    inflectionclass(stem) in COMPOUND_CLASSES
end

"""True if `inflclass` is a regular verb type that
requires only a single principle part.
$(SIGNATURES)
"""
function regularverbclass(stem::VerbStem)
    inflectionclass(stem) in REGULAR_VERB_CLASSES
end

"""True if `inflclass` is a regular verb type that
requires only a single principle part.
$(SIGNATURES)
"""
function regularverbclass(r::Rule)
    inflectionclass(r) in REGULAR_VERB_CLASSES
end


"""True if `inflclass` is a regular verb type that
requires only a single principle part.
$(SIGNATURES)
"""
function regularverbclass(s::AbstractString)
   s in REGULAR_VERB_CLASSES
end

"""True if rule requires first principal part.
$(SIGNATURES)
"""
function pp1(rule::R) where {R <: KanonesVerbalRule}
    gmpTense(rule) == gmpTense("present") ||     gmpTense(rule) == gmpTense("imperfect") 
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
    k = strcat(ortho, stemstring(stem), "κ")
end

function kappabase(s::AbstractString; ortho = literaryGreek())
    k = strcat(ortho, s, "κ")
end


"""Compose regular verb base for second or third
principal part.
$(SIGNATURES)
"""
function sigmabase(stem::Stem; ortho = literaryGreek())
    s = stemstring(stem)
    strcat(ortho, s,"σ")
end

"""Compose regular verb base for second or third
principal part.
$(SIGNATURES)
"""
function sigmabase(s::AbstractString; ortho = literaryGreek())
    strcat(ortho, s,"σ")
end

"""Compose regular verb base for sixth
principal part.
$(SIGNATURES)
"""
function thetabase(stem::Stem; ortho = literaryGreek())
    s = stemstring(stem)
    strcat(ortho, s,"θ")
end

function thetabase(s::AbstractString; ortho = literaryGreek())
    strcat(ortho, s,"θ")
end


function alphastem(stem::VerbStem, rule::R; ortho = literaryGreek()) where {R <: KanonesVerbalRule}
    #if pp2(rule)  || pp3(rule) || pp4(rule) || pp5(rule) || pp6(rule)
    if pp1(rule)
        stemstring(stem)
    else
       stemstring(stem) * "η"
    end
end


function extendcompound(stem::VerbStem, rule::R; ortho = literaryGreek()) where {R <: KanonesVerbalRule}
    @debug("Extend compound verb type s/r", stem, rule)
    if pp1(rule)
        stemstring(stem)

    elseif inflectionclass(stem) == "ew_contract" ||  inflectionclass(stem) == "ew_contract_dep" 
        stemstring(stem) * "η"
    elseif inflectionclass(stem) == "aw_contract" ||  inflectionclass(stem) == "aw_contract_dep" 
       
        alphastem(stem, rule, ortho = ortho)

    elseif  inflectionclass(stem) == "ow_contract" ||  inflectionclass(stem) == "ow_contract_dep" 
        stemstring(stem) * "ω"
    end

end

function izwbase(stem::VerbStem, rule::R; ortho = literaryGreek()) where {R <: KanonesVerbalRule}
    if pp3(rule) || pp5(rule)
        sigmabase(stemstring(stem), ortho = ortho)
    elseif pp4(rule)
        kappabase(stemstring(stem), ortho = ortho)
    elseif pp6(rule)
        extension1 = sigmabase(stemstring(stem), ortho = ortho)
        @debug("Extend to 1/2 ", extension1, thetabase(extension1, ortho = ortho))
        thetabase(extension1, ortho = ortho)
    else
        stemstring(stem) 
    end
end

"""Compose base stem of `stem` for principalpart required by `rule`.
$(SIGNATURES)
"""
function ppbase(stem::VerbStem, rule::R; ortho = literaryGreek()) where {R <: KanonesVerbalRule}
    stemstr = compoundtype(stem) ? extendcompound(stem, rule, ortho = ortho) : stemstring(stem)

    if inflectionclass(stem) == "izw"
        izwbase(stem, rule, ortho = ortho)


    elseif pp2(rule) || pp3(rule)
        sigmabase(stemstr, ortho = ortho)
    elseif pp4(rule)
        kappabase(stemstr, ortho = ortho)
    elseif pp6(rule)
        thetabase(stemstr, ortho = ortho)
    else
        stemstr
    end
end

"""Compose stem for appropriate principal part of a completely
regular verb.
$(SIGNATURES)
"""
function principalpart(stem::VerbStem, rule::R; ortho = literaryGreek()) where {R <: KanonesVerbalRule}
    @debug("Principal part for stem/rule", stem ,rule)
    extended = ppbase(stem, rule, ortho = ortho)
    @debug("principal part got extended base", extended)
    morphemes = split(extended, "#")

    morphbase = morphemes[end]
    if compoundtype(stem)
        @debug("COMPOUND ", morphbase, stem)
    end
    if takesreduplication(greekForm(rule), inflectionclass(rule))
        morphbase = reduplicate(morphbase, ortho)
    end
    @debug("CHECK augment for rule ", greekForm(rule))
    if rule isa FiniteVerbRule && takesaugment(greekForm(rule))
        morphbase = augment(morphbase, ortho)
        @debug("Augmented:", morphbase)
        morphbase
    end
    if length(morphemes) == 1
        @debug("principal part returning ", morphbase)
        morphbase
    else
        prefix = strcat(ortho, morphemes[1:end-1]...)
        @debug("Prefix is $(prefix)")
        strcat(ortho, prefix, rmbreathing(morphbase,ortho); elision = true)
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

"""True if finite verb form `f` takes reduplication.
$(SIGNATURES)
"""
function takesreduplication(f::GMFFiniteVerb, inflclass) 
    
    goodtense = gmpTense(f) == gmpTense("perfect")  ||
    gmpTense(f) == gmpTense("pluperfect")  


    goodtense && regularverbclass(inflclass)

end



"""True if infinitive form `f` takes reduplication.
$(SIGNATURES)
"""
function takesreduplication(f::GMFInfinitive, inflClass)
    regularverbclass(inflClass) && gmpTense(f) == gmpTense("perfect") 
end



"""True if participle form `f` takes reduplication.
$(SIGNATURES)
"""
function takesreduplication(f::GMFParticiple, inflClass)
    regularverbclass(inflClass) && gmpTense(f) == gmpTense("perfect") 
end