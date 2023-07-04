"A record for a single irregular verb stem."
struct IrregularInfinitiveStem <: KanonesIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    tense::GMPTense
    voice::GMPVoice
    inflectionclass
end


"""Identify tense of `inf`.
$(SIGNATURES)
"""
function gmpTense(inf::IrregularInfinitiveStem)
    inf.tense
end


"""Identify voice of `inf`.
$(SIGNATURES)
"""
function gmpVoice(inf::IrregularInfinitiveStem)
    inf.voice
end




"""Irregular noun stems are citable by Cite2Urn"""
CitableTrait(::Type{IrregularInfinitiveStem}) = CitableByCite2Urn()
"""Human-readlable label for an `IrregularInfinitiveStem`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(inf::IrregularInfinitiveStem)
    string("Irregular infinitive form ", inf.form, " (", label(inf.tense)," ", label(inf.voice), ")")
end

"""Identifying URN for an `IrregularNounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(inf::IrregularInfinitiveStem; registry = nothing)
    if isnothing(registry)
        inf.stemid
    else
        expand(inf.stemid, registry)
    end
end


"""Compose CEX text for an `IrregularInfinitiveStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(inf::IrregularInfinitiveStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([inf.stemid, label(inf), stemstring(inf), lexeme(inf), inflectionclass(inf), label(inf.tense), label(inf.voice) ], delimiter)
    else
        c2urn = expand(inf.stemid, registry)
        join([c2urn, label(inf), stemstring(inf), lexeme(inf), inflectionclass(inf), label(inf.tense), label(inf.voice)], delimiter)
    end
end



"""
Read one row of a stems table for irregular infinititve tokens and create an `IrregularInfinitiveStem`.

$(SIGNATURES)    
"""
function readstemrow(infinio::Kanones.IrregularInfinitiveIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)


    if length(parts) < 5
        msg = "Too few parts in $delimited."
        @warn msg
        throw(new(ArgumentError(msg)))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = knormal(parts[3])
    t = gmpTense(parts[4])
    v = gmpVoice(parts[5])
    inflclass = parts[6]

    IrregularInfinitiveStem(stemid,lexid,stem,t,v, inflclass)

end






"""Identify value of stem string for `inf`.
$(SIGNATURES)
"""
function stemstring(inf::IrregularInfinitiveStem)
    inf.form |> knormal
end

"""Identify lexeme for `inf`.
$(SIGNATURES)
"""
function lexeme(inf::IrregularInfinitiveStem)
    inf.lexid
end

"""Identify inflection class for `inf`.
$(SIGNATURES)
"""
function inflectionclass(inf::IrregularInfinitiveStem)
    inf.inflectionclass
end




"""Compose a digital code string for the form identified in `inf`.
$(SIGNATURES)
"""
function code(inf::IrregularInfinitiveStem)
      # PosPNTMVGCDCat
     string( INFINITIVE,"00$(code(inf.tense))0$(code(inf.voice))0000")
end


"""Compose an abbreviated URN for a rule from a `IrregularAdjectiveStem`.

$(SIGNATURES)
"""
function formurn(inf::IrregularInfinitiveStem)
    FormUrn("$(COLLECTION_ID)." * code(inf))
end

function greekForm(inf::IrregularInfinitiveStem) 
    formurn(inf) |> greekForm
end
