"A record for a single adjective stem."
struct AdjectiveStem <: KanonesStem
    stemid::StemUrn
    lexid::LexemeUrn
    form::AbstractString
    inflectionclass::AbstractString
    accentpersistence::AbstractString
end



function show(io::IO, adj::AdjectiveStem)
    print(io, label(adj))
end

function ==(adj1::AdjectiveStem, adj2::AdjectiveStem)
    adj1.stemid == adj2.stemid &&
    adj1.lexid == adj2.lexid &&
    adj1.form == adj2.form &&
    adj1.inflectionclass == adj2.inflectionclass && 
    adj1.accentpersistence == adj2.accentpersistence
end




"""Adjective stems are citable by Cite2Urn"""
CitableTrait(::Type{AdjectiveStem}) = CitableByCite2Urn()
function citabletrait(::Type{AdjectiveStem})
    CitableByCite2Urn()
end


"""Human-readlable label for an `AdjectiveStem`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(astem::AdjectiveStem)
    string("Adjective stem ", astem.form, "- (type ", astem.inflectionclass, ")")
end

"""Identifying URN for an `AdjectiveStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(adj::AdjectiveStem; registry = nothing)
    if isnothing(registry)
        adj.stemid
    else
        expand(adj.stemid, registry)
    end
end

struct AdjStemCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{AdjectiveStem})  
    AdjStemCex()
end


"""Compose CEX text for an `AdjectiveStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(adj::AdjectiveStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([id(adj), lexeme(adj),  stemstring(adj),inflectionclass(adj),  adj.accentpersistence ], delimiter)

    else
        c2urn = expand(adj.stemid, registry)
        lexurn = expand(adj.lexid, registry)
        join([c2urn,lexurn, stemstring(adj),  inflectionclass(adj),  adj.accentpersistence], delimiter)
    end
end


function fromcex(traitvalue::AdjStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)

    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = knormal(parts[3])
    inflclass = parts[4]
    accent = parts[5]
    AdjectiveStem(stemid,lexid,stem,inflclass,accent)

end


function pos(cvs::AdjectiveStem)
    :adjective
end




"""Identify value of stem string for `adj`.
$(SIGNATURES)
"""
function stemstring(adj::AdjectiveStem)
    adj.form |> knormal
end



"""Identify lexeme for `adj`.
$(SIGNATURES)
"""
function lexeme(adj::AdjectiveStem)
    adj.lexid
end

"""Identify inflection class for `adj`.
$(SIGNATURES)
"""
function inflectionclass(adj::AdjectiveStem)
    adj.inflectionclass
end


"""Identify inflection class for `adj`.
$(SIGNATURES)
"""
function id(adj::AdjectiveStem)
    adj.stemid
end

