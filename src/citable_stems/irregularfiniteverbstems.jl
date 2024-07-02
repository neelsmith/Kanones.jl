"A record for a single irregular verb stem."
struct IrregularVerbStem <: KanonesIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    vperson::GMPPerson
    vnumber::GMPNumber
    vtense::GMPTense
    vmood::GMPMood
    vvoice::GMPVoice
    inflectionclass::AbstractString
end
#irregverb.irregverbnn26447a|lsj.n26447|δίδωσι|
#third|singular|present|indicative|active|irregularfiniteverb




function show(io::IO, verb::IrregularVerbStem)
    print(io, label(verb))
end

function ==(v1::IrregularVerbStem, v2::IrregularVerbStem)
    v1.stemid == v2.stemid &&
    v1.lexid == v2.lexid &&
    v1.form == v2.form &&

    v1.vperson == v2.vperson &&
    v1.vnumber == v2.vnumber &&
    v1.vtense == v2.vtense &&
    v1.vmood == v2.vmood &&
    v1.vvoice == v2.vvoice &&
    v1.inflectionclass == v2.inflectionclass 
   
end




"""Irregular verb stems are citable by Cite2Urn"""
CitableTrait(::Type{IrregularVerbStem}) = CitableByCite2Urn()
function citabletrait(::Type{IrregularVerbStem})
    CitableByCite2Urn()
end

"""Human-readlable label for an `IrregularVerbStem`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(verb::IrregularVerbStem)
    string("Irregular verb form ", verb.form, " (", label(verb.vperson), " ", label(verb.vnumber), " ", label(verb.vtense)," ", label(verb.vmood), " ", label(verb.vvoice), ")")
end

"""Identifying URN for an `IrregularNounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(verb::IrregularVerbStem; registry = nothing)
    if isnothing(registry)
        verb.stemid
    else
        expand(verb.stemid, registry)
    end
end



struct IrregularVerbStemCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{IrregularVerbStem})  
    IrregularVerbStemCex()
end


"""Compose CEX text for an `IrregularVerbStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(verb::IrregularVerbStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([verb.stemid, lexeme(verb), stemstring(verb),  
        label(verb.vperson), label(verb.vnumber), label(verb.vtense), label(verb.vmood), label(verb.vvoice),
        inflectionclass(verb)  ], delimiter)
    else
        c2urn = expand(verb.stemid, registry)
        lexurn = expand(verb.lexid, registry)
        join([c2urn, lexurn, stemstring(verb), 
        label(verb.vperson), label(verb.vnumber), label(verb.vtense), label(verb.vmood), label(verb.vvoice), inflectionclass(verb) ], delimiter)
    end
end

function fromcex(traitvalue::IrregularVerbStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    
    if length(parts) < 9
        msg = "Too few parts in $delimited."
        @warn msg
        throw(ArgumentError(msg))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = knormal(parts[3])
    p = gmpPerson(parts[4])
    n = gmpNumber(parts[5])
    t = gmpTense(parts[6])
    m = gmpMood(parts[7])
    v = gmpVoice(parts[8])
    inflclass = parts[9]

    IrregularVerbStem(stemid,lexid,stem,p,n,t,m,v, inflclass)

end


function pos(vb::IrregularVerbStem)
    :verb
end

"""Identify person of `verb`.
$(SIGNATURES)
"""
function gmpPerson(verb::IrregularVerbStem)
    verb.vperson
end


"""Identify tense of `verb`.
$(SIGNATURES)
"""
function gmpNumber(verb::IrregularVerbStem)
    verb.vnumber
end




"""Identify tense of `verb`.
$(SIGNATURES)
"""
function gmpTense(verb::IrregularVerbStem)
    verb.vtense
end

"""Identify mood of `verb`.
$(SIGNATURES)
"""
function gmpMood(verb::IrregularVerbStem)
    verb.vmood
end


"""Identify voice of `verb`.
$(SIGNATURES)
"""
function gmpVoice(verb::IrregularVerbStem)
    verb.vvoice
end

#=

"""
Read one row of a stems table for irregular finite verb tokens and create an `IrregularVerbStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::Kanones.IrregularVerbIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    # Example:
    #irregverb.irregverbnn26447b|lsj.n26447|διδόασι|third|plural|present|indicative|active|irregularfiniteverb
    if length(parts) < 9
        msg = "Too few parts in $delimited."
        @warn msg
        throw(ArgumentError(msg))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = knormal(parts[3])
    p = gmpPerson(parts[4])
    n = gmpNumber(parts[5])
    t = gmpTense(parts[6])
    m = gmpMood(parts[7])
    v = gmpVoice(parts[8])
    inflclass = parts[9]

    IrregularVerbStem(stemid,lexid,stem,p,n,t,m,v, inflclass)
end

=#








"""Identify value of stem string for `verb`.
$(SIGNATURES)
"""
function stemstring(verb::IrregularVerbStem)
    verb.form |> knormal
end

"""Identify lexeme for `verb`.
$(SIGNATURES)
"""
function lexeme(verb::IrregularVerbStem)
    verb.lexid
end

"""Identify inflection class for `verb`.
$(SIGNATURES)
"""
function inflectionclass(verb::IrregularVerbStem)
    verb.inflectionclass
end




"""Compose a digital code string for the form identified in `verb`.
$(SIGNATURES)
"""
function code(verb::IrregularVerbStem)
      # PosPNTMVGCDCat
     string( FINITEVERB,"$(code(verb.vperson))$(code(verb.vnumber))$(code(verb.vtense))$(code(verb.vmood))$(code(verb.vvoice))0000")
end


"""Compose an abbreviated URN for a rule from a `IrregularAdjectiveStem`.

$(SIGNATURES)
"""
function formurn(verb::IrregularVerbStem)
    FormUrn("$(COLLECTION_ID)." * code(verb))
end

function greekForm(verb::IrregularVerbStem) 
    formurn(verb) |> greekForm
end

