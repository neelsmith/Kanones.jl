#LSJ_URL = "https://raw.githubusercontent.com/neelsmith/Kanones.jl/main/lsj/lsj-lemmata.cex"

"""Download dictionary of labelling lemmata for manually validated LSJ data set.
$(SIGNATURES)
"""
function lsjdict()::Dict{String,String}
    @info("Downloading dictionary of lemmata for `lsj` dataset...")
    lsjurl = "https://raw.githubusercontent.com/neelsmith/Kanones.jl/dev/datasets/lsj-vocab/lexemes/lsj.cex"
    lsjstr = Downloads.download(lsjurl) |> read |> String
    lsjlines = split(lsjstr, "\n")

    dict = Dict{String, String}()

    #p(readlines(f)) do ln
    for ln in lsjlines[2:end]
		cols = split(ln, "|")
		if length(cols) == 2
            id = LexemeUrn(cols[1]).objectid |> string
			dict[id] = cols[2] |> string
		end
	end
	dict
end


"""Download dictionary of labelling lemmata for lexemes in `lsjx` dataset.
$(SIGNATURES)
"""
function lsjxdict()::Dict{String,String}
    @info("Downloading dictionary of lemmata for `lsjx` dataset...")
    lsjxurl = "https://raw.githubusercontent.com/neelsmith/Kanones.jl/dev/datasets/lsj-vocab/lexemes/lsjx.cex"
    lsjxstr = Downloads.download(lsjxurl) |> read |> String
    lsjxlines = split(lsjxstr, "\n")

    dict = Dict{String, String}()

    for ln in lsjxlines[2:end]
		cols = split(ln, "|")
		if length(cols) == 2
            id = LexemeUrn(cols[1]).objectid |> string
			dict[id] = cols[2] |> string
		end
	end
	dict
end

"""
"""
function lemmatadict()::Dict{String, String}
    merge(lsjdict(), lsjxdict())
end


"""Retreive LSJ lemmata, and create a dictionary of abbreviated URN strings to lemmata.

$(SIGNATURES)
"""
function lsjdict(f)
    CSV.File(f) |> Dict
end


"""Compose a label string with LSJ lemma added as a subref to
a LexemeUrn string for the given Cite2Urn.

$(SIGNATURES)
"""
function lemmalabel(u::Cite2Urn; dict = lemmatadict())
    lexstr = collectionid(u) * "."  * objectcomponent(u)
	lemmalabel(lexstr, dict = dict)
end


"""Compose a label string with LSJ lemma added as subref to a LexemeUrn.

$(SIGNATURES)
"""
function lemmalabel(lexurn::LexemeUrn; dict = lemmatadict())
	lemmalabel(string(lexurn), dict = dict)
end


"""Add LSJ lemma as subref to abbreviated URN string.

$(SIGNATURES)
"""
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
