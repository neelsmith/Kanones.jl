LSJ_URL = "https://raw.githubusercontent.com/neelsmith/Kanones.jl/main/lsj/lsj-lemmata.cex"



"""Retreive LSJ lemmata online, and create a dictionary of abbreviated URN strings to lemmata.

$(SIGNATURES)
"""
function lsjdict_fromurl()
    CSV.File(HTTP.get(Kanones.LSJ_URL).body) |> Dict
end



"""Retreive LSJ lemmata, and create a dictionary of abbreviated URN strings to lemmata.

$(SIGNATURES)
"""
function lsjdict(f)
    CSV.File(f) |> Dict
end


"""Add LSJ lemma as subref to abbreviated URN string.

$(SIGNATURES)
"""
function attach_lemma(str::AbstractString, dict)
    if haskey(dict, str)
        string(str,"@", dict[str])
    else
        string(str,"@nolabel")
    end
end


function attach_lemma(lex::LexemeUrn, dict)
    attach_lemma(string(lex), dict)
end