"""A record for a single uninflected stem.

$(SIGNATURES)
"""
struct VerbStem <: KanonesStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    stemclass::AbstractString 
    augmented::Bool 
end

function show(io::IO, verb::VerbStem)
    print(io, label(verb))
end

function ==(v1::VerbStem, v2::VerbStem)
    v1.stemid == v2.stemid &&
    v1.lexid == v2.lexid &&
    v1.form == v2.form &&
    v1.stemclass == v2.stemclass && 
    v1.augmented == v2.augmented
end


"""Regular verb stems are citable by Cite2Urn"""
CitableTrait(::Type{VerbStem}) = CitableByCite2Urn()
function citabletrait(::Type{VerbStem})
    CitableByCite2Urn()
end

"""Human-readlable label for a `VerbStem`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(vs::VerbStem)
    string("Verb stem ", 
        stemstring(vs),
        "- (", 
        lexeme(vs),     
        ", ", 
        "stem class ", inflectionclass(vs), ")")
end

"""Identifying URN for a `VerbStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(vs::VerbStem; registry = nothing)
    if isnothing(registry)
        vs.stemid
    else
        expand(vs.stemid, registry)
    end
end



struct VerbStemCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{VerbStem})  
    VerbStemCex()
end

"""Compose CEX text for a `VerbStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(vs::VerbStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([vs.stemid, lexeme(vs), stemstring(vs),  inflectionclass(vs), vs.augmented], delimiter)
    else
        c2urn = expand(vs.stemid, registry)
        lexurn = expand(ns.lexid, registry)
        join([c2urn, lexurn,  stemstring(vs),  inflectionclass(vs), vs.augmented], delimiter)
    end
end


function fromcex(traitvalue::VerbStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 5
        throw(ArgumentError("readstemrow for verb: too few parts in $(delimited)"))
    end
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = parts[3]
    stemclass = parts[4]
    augmented = lowercase(parts[5]) == "true" || lowercase(parts[5]) == "t"
    VerbStem(stemid,lexid,stem,stemclass, augmented)
end


function pos(vb::VerbStem)
    :verb
end



"""Identify value of stem string for `vs`.
$(SIGNATURES)
"""
function stemstring(vs::VerbStem)
   vs.form |> knormal
end

"""Identify lexeme for `vs`.
$(SIGNATURES)
"""
function lexeme(vs::VerbStem)
    vs.lexid
end

"""Identify inflection class for `vs`.
$(SIGNATURES)
"""
function inflectionclass(vs::VerbStem)
    vs.stemclass
end
