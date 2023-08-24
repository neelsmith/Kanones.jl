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


function pos(cvs::VerbStem)
    :verb
end


"""Verb stems are citable by Cite2Urn"""
CitableTrait(::Type{VerbStem}) = CitableByCite2Urn()


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


"""Compose CEX text for a `VerbStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(vs::VerbStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([vs.stemid, label(vs), stemstring(vs), lexeme(vs), inflectionclass(vs)], delimiter)
    else
        c2urn = expand(vs.stemid, registry)
        join([c2urn, label(vs), stemstring(vs), lexeme(vs), inflectionclass(vs)], delimiter)
    end
end




"""Implementation of reading one row of a stems table for finite verbs.

$(SIGNATURES)
"""
function readstemrow(usp::VerbIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 5
        throw(ArgumentError("readstemrow for verb: too few parts in $(delimited)"))
    end
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = parts[3]
    stemclass = parts[4]
    augmented = lowercase(parts[5]) == "true" || lowercase(parts[5]) == "t"
    VerbStem(stemid,lexid,stem,stemclass, augmented)
    # Rule|LexicalEntity|StemClass|Stem|
end
