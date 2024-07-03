"A record for a single irregular verb stem."
struct IrregularInfinitiveStem <: KanonesIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    tense::GMPTense
    voice::GMPVoice
    inflectionclass
end



function show(io::IO, verb::IrregularInfinitiveStem)
    print(io, label(verb))
end

function ==(v1::IrregularInfinitiveStem, v2::IrregularInfinitiveStem)
    v1.stemid == v2.stemid &&
    v1.lexid == v2.lexid &&
    v1.form == v2.form &&

  
    v1.tense == v2.tense &&
  
    v1.voice == v2.voice &&
    v1.inflectionclass == v2.inflectionclass 
   
end


"""Irregular noun stems are citable by Cite2Urn"""
CitableTrait(::Type{IrregularInfinitiveStem}) = CitableByCite2Urn()
function citabletrait(::Type{IrregularInfinitiveStem})
    CitableByCite2Urn()
end


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



struct IrregularInfinitiveStemCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{IrregularInfinitiveStem})  
    IrregularInfinitiveStemCex()
end


"""Compose CEX text for an `IrregularInfinitiveStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(inf::IrregularInfinitiveStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([inf.stemid, lexeme(inf), stemstring(inf),  
        label(inf.tense), label(inf.voice),
        inflectionclass(inf)  ], delimiter)
    else
        c2urn = expand(verb.stemid, registry)
        lexurn = expand(verb.lexid, registry)
        join([c2urn, lexurn, stemstring(verb), 
         label(verb.vtense),label(verb.vvoice), inflectionclass(verb) ], delimiter)
    end
end

function fromcex(traitvalue::IrregularInfinitiveStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)

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


function pos(inf::IrregularInfinitiveStem)
    :verb
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
