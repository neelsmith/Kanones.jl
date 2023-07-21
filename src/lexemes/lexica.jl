#LSJ_URL = "https://raw.githubusercontent.com/neelsmith/Kanones.jl/main/lsj/lsj-lemmata.cex"



"""Retreive LSJ lemmata, and create a dictionary of abbreviated URN strings to lemmata.

$(SIGNATURES)
"""
function lsjdict(f)
    CSV.File(f) |> Dict
end

function lemmalabel(lexurn::LexemeUrn; dict = lemmatadict())
	lemmalabel(string(lexurn), dict = dict)
end

function lemmalabel(s::AbstractString;  dict = lemmatadict())
    if startswith(s, "lsjx.")
		stripped = replace(s, "lsjx." => "")
		haskey(dict, stripped) ? string(s, "@", dict[stripped]) : string(s, "@labelmissing")
	elseif startswith(s, "lsj.")
		stripped = replace(s, "lsj." => "")
		haskey(dict, stripped) ? string(s, "@", dict[stripped]) : 
		string(s, "@labelmissing")
	else
		string(s, "@nolabel")
	end
end

#=
"""Add LSJ lemma as subref to abbreviated URN string.

$(SIGNATURES)
"""
function attach_lemma(str::AbstractString, dict)
    if haskey(dict, str)
        string(str,"@", dict[str]) |> LexemeUrn
    else
        string(str,"@nolabel") |> LexemeUrn
    end
end


function attach_lemma(lex::LexemeUrn, dict)
    attach_lemma(string(lex), dict)
end

function attach_lemma(cite2urn::Cite2Urn, dict)
    str = join([collectionid(cite2urn), objectcomponent(cite2urn)], ".")
    lemmatized = haskey(dict, str) ? string(str,"@", dict[str]) : string(str, "@nolabel")
    addobject(cite2urn, lemmatized)
end
=#