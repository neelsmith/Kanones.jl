"A record for a single irregular noun stem."
struct IrregularAdjectiveStem <: KanonesIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    adjgender::GMPGender
    adjcase::GMPCase
    adjnumber::GMPNumber
    adjdegree::GMPDegree
    inflectionclass
end





function show(io::IO, adj::IrregularAdjectiveStem)
    print(io, label(adj))
end

function ==(a1::IrregularAdjectiveStem, a2::IrregularAdjectiveStem)
    a1.stemid == a2.stemid &&
    a1.lexid == a2.lexid &&
    a1.form == a2.form &&

  
    a1.adjgender == a2.adjgender &&
    a1.adjcase == a2.adjcase &&
    a1.adjnumber == a2.adjnumber &&
    a1.adjdegree == a2.adjdegree &&


    inflectionclass(a1) == inflectionclass(a2)
   
end



"""Irregular adjective stems are citable by Cite2Urn"""
CitableTrait(::Type{IrregularAdjectiveStem}) = CitableByCite2Urn()
function citabletrait(::Type{IrregularAdjectiveStem})
    CitableByCite2Urn()
end

"""Human-readlable label for an `IrregularAdjectiveStem`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(astem::IrregularAdjectiveStem)
    string("Irregular adjective form ", astem.form, " (", label(astem.adjgender), " ", label(astem.adjcase), " ", label(astem.adjnumber)," ", label(astem.adjdegree), ")")
end

"""Identifying URN for an `IrregularAdjectiveStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(adj::IrregularAdjectiveStem; registry = nothing)
    if isnothing(registry)
        adj.stemid
    else
        expand(adj.stemid, registry)
    end
end


struct IrregularAdjectiveStemCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{IrregularAdjectiveStem})  
    IrregularAdjectiveStemCex()
end


"""Compose CEX text for an `IrregularAdjectiveStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(adj::IrregularAdjectiveStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([adj.stemid, lexeme(adj), stemstring(adj),  
       
        label(gmpGender(adj)), label(gmpCase(adj)),label(gmpNumber(adj)),
        label(gmpDegree(adj)),


        inflectionclass(adj)  ], delimiter)
    else
        c2urn = expand(adj.stemid, registry)
        lexurn = expand(adj.lexid, registry)
        join([c2urn, lexurn, stemstring(adj), 
        
        
        label(gmpGender(adj)), label(gmpCase(adj)),label(gmpNumber(adj)),
        label(gmpDegree(adj)),

        inflectionclass(adj) ], delimiter)
    end
end

function fromcex(traitvalue::IrregularAdjectiveStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 8
        msg = "Too few parts in $delimited."
        @warn msg
        throw(new(ArgumentError(msg)))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = knormal(parts[3])
    g = gmpGender(parts[4])
    c = gmpCase(parts[5])
    n = gmpNumber(parts[6])
    d = gmpDegree(parts[7])
    inflclass = parts[8]

    IrregularAdjectiveStem(stemid,lexid,stem,g,c,n,d,inflclass)
end




function pos(adj::IrregularAdjectiveStem)
    :adjective
end

"""Identify gender of `adj`.
$(SIGNATURES)
"""
function gmpGender(adj::IrregularAdjectiveStem)
    adj.adjgender
end


"""Identify case of `adj`.
$(SIGNATURES)
"""
function gmpCase(adj::IrregularAdjectiveStem)
    adj.adjcase
end


"""Identify number of `adj`.
$(SIGNATURES)
"""
function gmpNumber(adj::IrregularAdjectiveStem)
    adj.adjnumber
end


"""Identify degree of `adj`.
$(SIGNATURES)
"""
function gmpDegree(adj::IrregularAdjectiveStem)
    adj.adjdegree
end


"""Identify value of stem string for `adj`.
$(SIGNATURES)
"""
function stemstring(adj::IrregularAdjectiveStem)
    adj.form |> knormal
end

"""Identify lexeme for `adj`.
$(SIGNATURES)
"""
function lexeme(adj::IrregularAdjectiveStem)
    adj.lexid
end

"""Identify inflection class for `adj`.
$(SIGNATURES)
"""
function inflectionclass(adj::IrregularAdjectiveStem)
    adj.inflectionclass
end




"""Compose a digital code string for the form identified in `adj`.
$(SIGNATURES)
"""
function code(adj::IrregularAdjectiveStem)
      # PosPNTMVGCDCat
     string( ADJECTIVE,"0",code(adj.adjnumber),"000",code(adj.adjgender),code(adj.adjcase), code(adj.adjdegree), "0")
end


"""Compose an abbreviated URN for a rule from a `IrregularAdjectiveStem`.

$(SIGNATURES)
"""
function formurn(adj::IrregularAdjectiveStem)
    FormUrn("$(COLLECTION_ID)." * code(adj))
end

function greekForm(adj::IrregularAdjectiveStem) 
    formurn(adj) |> greekForm
end