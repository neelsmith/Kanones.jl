FOLIO_BASE_URL = "http://folio2.furman.edu/lsj/?urn=urn:cite2:hmt:lsj.chicago_md:"


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

    #p(readlines(f)) do ln
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

"""Format a markdown string representing an analyzed token and its morphological analyses.
$(SIGNATURES)
"""
function md_analysis(txt::AbstractString, alist::Vector{Analysis}; registry = nothing) 
    if isempty(alist)			
        "- $(txt). no analyses"
    else
        labelre = r"(.+):(.+)"
        alabels = map(alist) do a
            lbl = a.form |> greekForm |> label
            replace(lbl, labelre => s"*\1*:\2")
        end
        astring = join(alabels,"; **or** ")
        coll_list = map(alist) do a
            a.lexeme.collection
        end  |> unique
        if "lsjx" in coll_list
            txt = txt * "⚠️"
        end



        dict = isnothing(registry) ? lemmatadict() : registry
        lex_ids = map(alist) do a
            a.lexeme.objectid
        end |> unique
        lex_links = map(lex_ids) do lex

            if lex in keys(dict)
                lemma = string("**", dict[lex], "**")
                string("[", lemma, "](", FOLIO_BASE_URL, lex, ")")
            else
                ""
            end
        end
        lsj = join(lex_links," **or** ")
        if isempty(lsj)
            "- **$(txt)**. $(astring) (*Not in LSJ*)"
        else
            "- **$(txt)**. $(astring)  (*See LSJ: $(lsj)*)"
        end
    end
end
#=


				
				astring = join(alabels,"; **or** ")

				coll_list = map(alist) do a
					a.lexeme.collection
				end  |> unique
				if "lsjx" in coll_list
					txt = txt * "⚠️"
				end

				lex_ids = map(alist) do a
					a.lexeme.objectid
				end |> unique

				lex_links = map(lex_ids) do l
					lemma = string("**", lemmataDict[l], "**")
					string("[", lemma, "](", fubase, l, ")")
				end
				
				lsj = join(lex_links," **or** ")
				
				push!(strs, "- **$(txt)**. $(astring)  (*See LSJ: $(lsj)*)")
				
				
			end
		end
		Markdown.parse(join(strs, "\n"))
=#