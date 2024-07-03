"A record for a single noun stem."
struct NounStem <: KanonesStem
    stemid::StemUrn
    lexid::LexemeUrn
    form::AbstractString
    gender::GMPGender
    inflectionclass::AbstractString
    accentpersistence::AbstractString
end


function show(io::IO, noun::NounStem)
    print(io, label(noun))
end

function ==(n1::NounStem, n2::NounStem)
    n1.stemid == n2.stemid &&
    n1.lexid == n2.lexid &&
    n1.form == n2.form &&
    n1.gender == n2.gender &&
    n1.inflectionclass == n2.inflectionclass && 
    n1.accentpersistence == n2.accentpersistence
end



"""Regular noun stems are citable by Cite2Urn"""
CitableTrait(::Type{NounStem}) = CitableByCite2Urn()
function citabletrait(::Type{NounStem})
    CitableByCite2Urn()
end

"""Human-readlable label for a `NounStem`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(ns::NounStem)
    string("Noun stem ", ns.form, "- (", label(ns.gender), ")")
end


"""Identifying URN for a `NounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(ns::NounStem; registry = nothing)
    if isnothing(registry)
        ns.stemid
    else
        expand(ns.stemid, registry)
    end
end





struct NounStemCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{NounStem})  
    NounStemCex()
end

"""Compose CEX text for a `NounStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(ns::NounStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([id(ns), lexeme(ns),  stemstring(ns), label(ns.gender), inflectionclass(ns),  ns.accentpersistence ], delimiter)
    else
        c2urn = expand(ns.stemid, registry)
        lexurn = expand(ns.lexid, registry)
        join([c2urn,lexurn, stemstring(ns), label(ns.gender), inflectionclass(ns),  ns.accentpersistence], delimiter)
    end
#=
stemid
    lexid
    form::AbstractString
    gender::GMPGender
    inflectionclass
    accentpersistence
    =#
end


function fromcex(traitvalue::NounStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    
    stem = knormal(parts[3]) |> lowercase
    gender = gmpGender(parts[4])
    inflclass = parts[5]
    accent = parts[6]
    NounStem(stemid,lexid,stem,gender,inflclass,accent)
    
end

function pos(nounstem::NounStem)
    :noun
end


"""Identify value of stem string for `ns`.
$(SIGNATURES)
"""
function stemstring(ns::NounStem)
    ns.form |> knormal
end

"""Lexeme for a `NounStem`, as an 
abbreviated URN.
$(SIGNATURES)
"""
function lexeme(n::NounStem)
    n.lexid
end

"""Identify inflection class for `ns`.
$(SIGNATURES)
"""
function inflectionclass(ns::NounStem)
    ns.inflectionclass
end

"""Identify gender of `ns`.
$(SIGNATURES)
"""
function gmpGender(ns::NounStem)
    ns.gender
end




"""Identifier for a `NounStem`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(n::NounStem)
    n.stemid
end

