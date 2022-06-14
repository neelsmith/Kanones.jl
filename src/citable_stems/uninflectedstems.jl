
"A record for a single uninflected stem."
struct UninflectedStem <: KanonesStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    stemcategory::GMPUninflectedType
end


"""Uninfleced stems are citable by Cite2Urn"""
CitableTrait(::Type{UninflectedStem}) = CitableByCite2Urn()



"""Identify value of stem string for `uninfl`.
$(SIGNATURES)
"""
function stemstring(uninfl::UninflectedStem)
    uninfl.form |> knormal
end

"""Identify lexeme for `uninfl`.
$(SIGNATURES)
"""
function lexeme(uninfl::UninflectedStem)
    uninfl.lexid
end

"""Identify inflection class for `uninfl`.
$(SIGNATURES)
"""
function inflectionClass(uninfl::UninflectedStem)
    uninfl.stemcategory
end





"""Human-readlable label for an `UninflectedStem`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(us::UninflectedStem)
    string("Uninflected ", label(us.stemcategory), " ", us.form)
end


"""Identifying URN for a `NounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(us::UninflectedStem; registry = nothing)
    if isnothing(registry)
        us.stemid
    else
        expand(us.stemid, registry)
    end
end


"""Compose CEX text for a `UninflectedStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(us::UninflectedStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([us.stemid, label(us), stemstring(us), lexeme(us), label(inflectionClass(us)) ], delimiter)
    else
        c2urn = expand(us.stemid, registry)
        join([c2urn, label(us), stemstring(us), lexeme(us), label(inflectionClass(us)) ], delimiter)
    end
end

#ὁ|lsj.n71882|article
"""Identifier string for an `UninflectedStem`.

$(SIGNATURES)
"""
function id(uninfl::UninflectedStem)
    uninfl.stemid
end

"""Identify lexeme URN for an `UninflectedStem`.

$(SIGNATURES)
"""
function lexeme(uninfl::UninflectedStem)
    uninfl.lexid
end


"""Implementation of reading one row of a stems table for uninflected tokens.


$(SIGNATURES)
"""
function readstemrow(usp::UninflectedIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 4
        msg = "Invalid syntax for uninflected stem: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        stemid = StemUrn(parts[1])
        lexid = LexemeUrn(parts[2])
        form = parts[3]
        stemclass = gmpUninflectedType(parts[4])
        UninflectedStem(stemid, lexid, form, stemclass)
    end
end


"""Compose a digital code string for the form identified in `uninfl`.
$(SIGNATURES)
"""
function code(uninfl::UninflectedStem)
      # PosPNTMVGCDCat
     string( UNINFLECTED,"00000000", code(uninfl.stemcategory))
end


"""Compose an abbreviated URN for a rule from a `UninflectedStem`.

$(SIGNATURES)
"""
function formurn(uninfl::UninflectedStem)
    FormUrn("$(COLLECTION_ID)." * code(uninfl))
end



function greekForm(uninfl::UninflectedStem) 
    formurn(uninfl) |> greekForm
end

