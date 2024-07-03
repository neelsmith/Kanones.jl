"A record for a single irregular noun stem."
struct IrregularNounStem <: KanonesIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    noungender::GMPGender
    nouncase::GMPCase
    nounnumber::GMPNumber
    inflectiontype::AbstractString
end


function show(io::IO, noun::IrregularNounStem)
    print(io, label(noun))
end

function ==(n1::IrregularNounStem, n2::IrregularNounStem)
    n1.stemid == n2.stemid &&
    n1.lexid == n2.lexid &&
    n1.form == n2.form &&

  
    n1.noungender == n2.noungender &&
    n1.nouncase == n2.nouncase &&
    n1.nounnumber == n2.nounnumber &&


    n1.inflectiontype == n2.inflectiontype 
   
end



"""Irregular noun stems are citable by Cite2Urn"""
CitableTrait(::Type{IrregularNounStem}) = CitableByCite2Urn()
function citabletrait(::Type{IrregularNounStem})
    CitableByCite2Urn()
end
"""Human-readlable label for an `IrregularNounStem`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(ns::IrregularNounStem)
    string("Irregular noun form ", ns.form, " (", label(ns.noungender)," ", label(ns.nouncase), " ", label(ns.nounnumber), ")")
end


"""Identifying URN for an `IrregularNounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(ns::IrregularNounStem; registry = nothing)
    if isnothing(registry)
        ns.stemid
    else
        expand(ns.stemid, registry)
    end
end



struct IrregularNounStemCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{IrregularNounStem})  
    IrregularNounStemCex()
end

"""Compose CEX text for an `IrregularNounStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(ns::IrregularNounStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([ns.stemid, lexeme(ns), stemstring(ns),  
       
        label(ns.noungender), label(ns.nouncase),label(ns.nounnumber),

        inflectionclass(ns)  ], delimiter)
    else
        c2urn = expand(ns.stemid, registry)
        lexurn = expand(ns.lexid, registry)
        join([c2urn, lexurn, stemstring(ns), 
        
        label(ns.noungender), label(ns.nouncase),label(ns.nounnumber),

        inflectionclass(ns) ], delimiter)
    end
end


function fromcex(traitvalue::IrregularNounStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)


    # Example:
    #irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun
    if length(parts) < 7
        msg = "Too few parts in $(delimited)."
        @warn msg
        throw(new(ArgumentError(msg)))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = knormal(parts[3])
    g = gmpGender(parts[4])
    c = gmpCase(parts[5])
    n = gmpNumber(parts[6])
    inflclass = parts[7]

    IrregularNounStem(stemid,lexid,stem,g,c,n,inflclass)
end

function pos(nounstem::IrregularNounStem)
    :noun
end


"""Identify gender of `noun`.
$(SIGNATURES)
"""
function gmpGender(noun::IrregularNounStem)
    noun.noungender
end


"""Identify case of `noun`.
$(SIGNATURES)
"""
function gmpCase(noun::IrregularNounStem)
    noun.nouncase
end


"""Identify number of `noun`.
$(SIGNATURES)
"""
function gmpNumber(noun::IrregularNounStem)
    noun.nounnumber
end




"""Identify value of stem string for `noun`.
$(SIGNATURES)
"""
function stemstring(noun::IrregularNounStem)
    noun.form |> knormal
end

"""Identify lexeme for `noun`.
$(SIGNATURES)
"""
function lexeme(noun::IrregularNounStem)
    noun.lexid
end

"""Identify inflection class for `noun`.
$(SIGNATURES)
"""
function inflectionclass(noun::IrregularNounStem)
    noun.inflectiontype
end



"""Compose a digital code string for the form identified in `noun`.
$(SIGNATURES)
"""
function code(noun::IrregularNounStem)
      # PosPNTMVGCDCat
     string( NOUN,"0",code(noun.nounnumber),"000",code(noun.noungender),code(noun.nouncase),"00")
end


"""Compose an abbreviated URN for a rule from a `IrregularNounStem`.

$(SIGNATURES)
"""
function formurn(noun::IrregularNounStem)
    FormUrn("$(COLLECTION_ID)." * code(noun))
end



function greekForm(noun::IrregularNounStem) 
    formurn(noun) |> greekForm
end