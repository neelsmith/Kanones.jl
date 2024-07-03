struct RuleSet
    rules::Vector{CitableParserBuilder.Rule}
end

function show(io::IO, ruleset::RuleSet)
    print(io, "Rule set with ", length(ruleset.rules), " inflectional rules.")
end

struct CitableRuleSet <: CitableCollectionTrait end
function citablecollectiontrait(::Type{RuleSet}) 
    CitableRuleSet()
end

function urntype(rs::RuleSet)
    Cite2Urn
end

struct RuleSetCex <: CexTrait end
function cextrait(::Type{RuleSet})
    RuleSetCex()
end

function cex(rs::RuleSet; delimiter = "|", registry = nothing, header = true)
    hdr = header ? "#!citecollection\n" : ""
    expander = Dict("forms" => "urn:cite2:kanones:forms.v1:")
    strings = map(rs.rules) do r
        
        if isnothing(registry)
             join([ruleurn(r), label(r), ending(r), inflectionclass(r), formurn(r)], delimiter)
        else
            c2urn = expand(ruleurn(r), expander)
            formfullurn = expand(formurn(r), expander)
            join([c2urn, label(r), ending(r), inflectionclass(r), formfullurn], delimiter)
        end
    end
    hdr * join(strings, "\n")
end

function fromcex(trait::RuleSetCex, cexsrc::AbstractString, T; 
    delimiter = "|", configuration = nothing, strict = true)
    
    lines = split(cexsrc, "\n")

    datalines = filter(ln -> !isempty(ln), lines)
    for ln in datalines[2:end]
        cols = split(ln, delimiter)
        #@info(cols)
        
        id = cols[1]
        inflclass = cols[4]
        ending = cols[3]
        form = cols[5]
        @info("$(id), $(inflclass), $(ending), $(form):")

        @info("Look at")
        #@info(cols[3:4])
    end
    #=
    isbns = CitableBook[]
    inblock = false
    for ln in datalines
        if ln == "#!citecollection"
            inblock = true
        elseif inblock
            bk = fromcex(ln, CitableBook)
            push!(isbns, bk)
        end
    end
    ReadingList(isbns)
    =#
end


#=
Add ktype for rule set.

    It's a vector of rules (abstract)

    it supports CEX seriailization kusing urns for forms, in contrast to individual rule types that serialize to type-specific delimited data identical to what you do in a Kanones files data set.
=#