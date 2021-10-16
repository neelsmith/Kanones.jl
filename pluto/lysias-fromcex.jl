### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 23c85baa-0c74-459b-aea4-e3865f5ecbf8
begin
	using Pkg
	Pkg.add(url = "https://github.com/neelsmith/Kanones.jl")
	Pkg.add("CitableParserBuilder")
	Pkg.add("Orthography")
	Pkg.add("PolytonicGreek")
	Pkg.add("CitableText")
	Pkg.add("CitableCorpus")
	Pkg.add("PlutoUI")
	
	using Kanones
	using CitableParserBuilder
	
	using CitableText
	using CitableCorpus
	
	using Orthography
	using PolytonicGreek
	
	using PlutoUI
end

# ╔═╡ 4b757271-be49-415f-9df3-207737d0bf40
md"""# Analyze parsed output for Lysias"""

# ╔═╡ f416597d-f07d-46f5-8e12-712cd6ecbe42
html"""
<br/><br/><br/>
<hr/>

"""

# ╔═╡ 5eaa82ad-ebbc-48a7-ad4e-91eeb1de5627
md"""
> user interaction
"""

# ╔═╡ 4869ebfd-d46a-4ab3-9957-e64c0749786d
md"Pull out passages for user menu."

# ╔═╡ 5a1da098-ac37-49e1-ac18-569f3c84f733
function formatToken(atoken)
	isempty(atoken.analyses) ? "<span class=\"missing\">$(atoken.passage.text)</span>" : atoken.passage.text
end

# ╔═╡ 9c3e3e9c-e317-4a34-8383-69695cb7b74c
css = html"""
<style>
.missing {
  color: silver;  
}
</style>
"""

# ╔═╡ fead07b2-6909-42e8-9703-0eb0be2ac457
md"> load and set up data"

# ╔═╡ 9ea64b8f-e7aa-4bb2-9c0e-a51b9ba6e936
repo = dirname(pwd())

# ╔═╡ d805edb9-25bf-42dc-a57a-471a3947f10e
md"Read preparsed analyses."

# ╔═╡ 8baaf485-fd1f-445c-abd0-5c46816be7bf
md"""$(@bind loadem Button("Reload data"))"""

# ╔═╡ 74299b5f-fe7c-4085-9bca-1d9c6b99caac
analyses = begin
	loadem
	read(joinpath(repo, "lysias_parsed.cex"), String) |> 
	CitableParserBuilder.analyzedtokens_fromabbrcex
end

# ╔═╡ 2ca07e5b-9244-4230-bb8e-deb302ca095e
ortho = literaryGreek()

# ╔═╡ aea40b27-ca74-43b0-851a-624a3a7be06e
md"Load a text corpus."

# ╔═╡ 3cef06b1-5224-46fa-90d4-51819503a9b8
corpus = begin
	lysiasfile = joinpath(repo, "scratch", "lysias1.cex")
	read(lysiasfile) |> corpus_fromcex
end

# ╔═╡ 787a22f2-1fb8-476e-8dea-3b4a3ece1463
psgs = map(psg -> passagecomponent(psg.urn), corpus.passages)

# ╔═╡ df6fd6c7-b224-43db-a824-00dd16a7eb05
md"""Select a passage: $(@bind psg Select(psgs, default="1.6"))"""

# ╔═╡ d1f5babb-a882-4289-b673-74230e980967
selected = begin
	filter(a -> passagecomponent(collapsePassageBy(a.passage.urn,1 )) == psg, analyses)
end

# ╔═╡ d7943035-dabc-44c4-aab0-afe2fba69832
function formatTokens()
	results = ["<b>$(psg)</b> "]
	for tkn in selected
		push!(results,formatToken(tkn))
	end
	HTML(join(results, " "))
end

# ╔═╡ b69d4ffa-5c2d-4494-bcb8-e27ab8617b46
formatTokens()

# ╔═╡ 0db0b04a-59a8-4fa5-b770-8a8a9bea4e8f
alltokens = tokenizedcorpus(corpus, ortho)

# ╔═╡ Cell order:
# ╟─23c85baa-0c74-459b-aea4-e3865f5ecbf8
# ╟─4b757271-be49-415f-9df3-207737d0bf40
# ╟─8baaf485-fd1f-445c-abd0-5c46816be7bf
# ╟─df6fd6c7-b224-43db-a824-00dd16a7eb05
# ╟─b69d4ffa-5c2d-4494-bcb8-e27ab8617b46
# ╟─f416597d-f07d-46f5-8e12-712cd6ecbe42
# ╟─5eaa82ad-ebbc-48a7-ad4e-91eeb1de5627
# ╟─4869ebfd-d46a-4ab3-9957-e64c0749786d
# ╟─787a22f2-1fb8-476e-8dea-3b4a3ece1463
# ╟─5a1da098-ac37-49e1-ac18-569f3c84f733
# ╟─d7943035-dabc-44c4-aab0-afe2fba69832
# ╟─d1f5babb-a882-4289-b673-74230e980967
# ╟─9c3e3e9c-e317-4a34-8383-69695cb7b74c
# ╟─fead07b2-6909-42e8-9703-0eb0be2ac457
# ╟─9ea64b8f-e7aa-4bb2-9c0e-a51b9ba6e936
# ╟─d805edb9-25bf-42dc-a57a-471a3947f10e
# ╠═74299b5f-fe7c-4085-9bca-1d9c6b99caac
# ╟─2ca07e5b-9244-4230-bb8e-deb302ca095e
# ╟─aea40b27-ca74-43b0-851a-624a3a7be06e
# ╟─3cef06b1-5224-46fa-90d4-51819503a9b8
# ╟─0db0b04a-59a8-4fa5-b770-8a8a9bea4e8f
