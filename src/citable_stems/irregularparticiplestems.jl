"A record for a single irregular verb stem."
struct IrregularParticipleStem <: KanonesIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    ptense::GMPTense
    pvoice::GMPVoice
    pgender::GMPGender
    pcase::GMPCase
    pnumber::GMPNumber
    inflectionclass
end

function pos(cvs::IrregularParticipleStem)
    :verb
end

"""Irregular noun stems are citable by Cite2Urn"""
CitableTrait(::Type{IrregularParticipleStem}) = CitableByCite2Urn()

"""Human-readlable label for an `IrregularParticipleStem`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(p::IrregularParticipleStem)
    string("Irregular participle form ", p.form, " (", label(p.ptense)," ", label(p.pvoice), " ", label(p.pgender), " ", label(p.pcase), " ", label(p.pnumber))
end



"""Identifying URN for an `IrregularNounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(p::IrregularParticipleStem; registry = nothing)
    if isnothing(registry)
        p.stemid
    else
        expand(p.stemid, registry)
    end
end



"""Compose CEX text for an `IrregularParticipleStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(p::IrregularParticipleStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([p.stemid, label(p), stemstring(p), lexeme(p), inflectionclass(p), label(p.ptense), label(p.pvoice), label(p.pgender), label(p.pcase), label(p.pnumber) ], delimiter)
    else
        c2urn = expand(p.stemid, registry)
        join([c2urn, label(p), stemstring(p), lexeme(p), inflectionclass(p), label(p.ptense), label(p.pvoice), label(p.pgender), label(p.pcase), label(p.pnumber) ], delimiter)
    end
end


"""Identify value of stem string for `inf`.
$(SIGNATURES)
"""
function stemstring(p::IrregularParticipleStem)
    p.form |> knormal
end


"""
Read one row of a stems table for irregular infinititve tokens and create an `IrregularInfinitiveStem`.

$(SIGNATURES)    
"""
function readstemrow(ptcplio::Kanones.IrregularParticipleIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)


    if length(parts) < 9
        msg = "readstemrow for irregular participle: too few parts in $delimited."
        @warn msg
        throw(new(ArgumentError(msg)))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = knormal(parts[3])
    t = gmpTense(parts[4])
    v = gmpVoice(parts[5])
    g = gmpGender(parts[6])
    c = gmpCase(parts[7])
    n = gmpNumber(parts[8])
    inflclass = parts[9]

    IrregularParticipleStem(stemid,lexid,stem,t,v,g,c,n, inflclass)

end



"""Identify lexeme for `inf`.
$(SIGNATURES)
"""
function lexeme(p::IrregularParticipleStem)
    p.lexid
end

"""Identify inflection class for `inf`.
$(SIGNATURES)
"""
function inflectionclass(p::IrregularParticipleStem)
    p.inflectionclass
end




"""Compose a digital code string for the form identified in `inf`.
$(SIGNATURES)
"""
function code(p::IrregularParticipleStem)
      # PosPNTMVGCDCat
     string( PARTICIPLE,"0$(code(p.pnumber))$(code(p.ptense))0$(code(p.pvoice))$(code(p.pgender))$(code(p.pcase))00")
end


"""Compose an abbreviated URN for a rule from a `IrregularAdjectiveStem`.

$(SIGNATURES)
"""
function formurn(p::IrregularParticipleStem)
    FormUrn("$(COLLECTION_ID)." * code(p))
end

function greekForm(p::IrregularParticipleStem) 
    formurn(p) |> greekForm
end



################
"""Identify gender of `ptcpl`.
$(SIGNATURES)
"""
function gmpGender(ptcpl::IrregularParticipleStem)
    ptcpl.pgender
end

"""Identify case of `ptcpl`.
$(SIGNATURES)
"""
function gmpCase(ptcpl::IrregularParticipleStem)
    ptcpl.pcase
end


"""Identify number of `ptcpl`.
$(SIGNATURES)
"""
function gmpNumber(ptcpl::IrregularParticipleStem)
    ptcpl.pnumber
end




"""Identify tense of `ptcpl`.
$(SIGNATURES)
"""
function gmpTense(ptcpl::IrregularParticipleStem)
    ptcpl.ptense
end



"""Identify voice of `ptcpl`.
$(SIGNATURES)
"""
function gmpVoice(ptcpl::IrregularParticipleStem)
    ptcpl.pvoice
end


