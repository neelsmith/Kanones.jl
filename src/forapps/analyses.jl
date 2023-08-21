FOLIO_BASE_URL = "http://folio2.furman.edu/lsj/?urn=urn:cite2:hmt:lsj.chicago_md:"


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
