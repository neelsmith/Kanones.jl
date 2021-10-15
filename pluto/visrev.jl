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

# ╔═╡ 405697fa-2dd2-11ec-3ed2-231cc433c3f2
begin
	using Pkg
	
	
	Pkg.add("Orthography")
	Pkg.add(name="PolytonicGreek", version="0.13")
	
	Pkg.add(name="CitableText", version="0.11")
	Pkg.add(name="CitableCorpus", version="0.7")
	
	
	Pkg.add("CitableParserBuilder")
	Pkg.add(url="https://github.com/neelsmith/Kanones.jl")
	
	Pkg.add("PlutoUI")
	
	using Kanones, Kanones.FstBuilder
	using CitableParserBuilder
	
	using PolytonicGreek, Orthography
	using CitableText, CitableCorpus
	
	using PlutoUI

end

# ╔═╡ 33b04d82-dd06-4e14-a1a5-38d9eff4f39a
md"""This is **not yet** a reproducible notebook.

The following cell can be updated when Kanones is published to juliahub.
"""

# ╔═╡ a16a811c-def6-4daf-bf0a-a8de1e913db7
md"""# Visualize parsing in Lysias"""

# ╔═╡ 2a325e68-0a41-4183-8e28-958c41faaf7f
html"""
<br/><br/><br/><br/>
"""

# ╔═╡ 607e0cbb-407d-4519-9420-17f79486f02e
html"""
<br/><br/>
<hr/><hr/>
<br/><br/>
"""

# ╔═╡ c131d3a2-1d7e-4568-8978-e2b2e76528df
md"""
> user interaction
"""

# ╔═╡ a907b1cd-f8f6-49cf-a98a-2fb71d45a2b9
md"Pull out passage references for user menu."

# ╔═╡ 17b290f2-3e8e-4565-a9da-13d39e9d0d4b
md"Make a tokenized corpus from the selected passage."

# ╔═╡ 67475df5-1ad8-43e6-b766-aa86f7fe0b61
md"Parse selected tokens"

# ╔═╡ b8a4209e-cb5f-4ce3-947a-bfae77688c6e
md"""> Visual formatting"""

# ╔═╡ 02013e45-03ae-45d2-b2cb-7a8b009c46ac
function formatToken(atoken)
	isempty(atoken.analyses) ? "<span class=\"missing\">$(atoken.passage.text)</span>" : atoken.passage.text
end

# ╔═╡ 0c7a0ba8-e9cb-4259-9873-e62515e942dc
css = html"""
<style>
.missing {
  color: silver;  
}
</style>
"""

# ╔═╡ a7244e41-7ae3-439e-ae51-12f915342ac2
md"""


> load data and set up
"""

# ╔═╡ d69ebc92-49a4-4909-88c4-dc00433bd84b
md"Parent directory of this notebook is the repository root."

# ╔═╡ 260a62ba-6728-4902-abc7-6033d0035e0b
root = pwd() |> dirname

# ╔═╡ 45042f08-0ecc-4868-9893-1f46278c7ab0
md"Build a parser."

# ╔═╡ 5f53329f-dbb6-4af6-bfe1-01f4ca6a63da
function lysiasparser(rootdir)
    fstsrc  =  joinpath(rootdir, "fst")
    coreinfl = joinpath(rootdir, "datasets", "core-infl")
    corevocab = joinpath(rootdir, "datasets", "core-vocab")
    lysias = joinpath(pwd(), "datasets", "lysias")
    lysiasnouns = joinpath(rootdir,  "datasets","lysias-nouns")

    datasets = [corevocab, coreinfl, lysias, lysiasnouns]
    kd = Kanones.Dataset(datasets)
    tgt = joinpath(rootdir,  "parsers", "lysiasparser")
    buildparser(kd,fstsrc, tgt)
end

# ╔═╡ ded514f6-56b9-4297-a72a-a2b9a3866bab
p = lysiasparser(root)

# ╔═╡ 1f909578-1122-4fbc-a7db-b528a5bdb13b
md"Load a text corpus."

# ╔═╡ 089b6143-21dd-44ac-95a9-672c938aa4de
corpus = begin
	f = joinpath(root, "scratch", "lysias1.cex")
	read(f) |> corpus_fromcex
end

# ╔═╡ d3e7cb60-08f4-4ee0-b1f3-aeccae3a7cdb
psgs = map(psg -> passagecomponent(psg.urn), corpus.passages)

# ╔═╡ 7b71dc16-0309-4855-97ed-2dddd9783c25
md"""Passage: $(@bind psg Select(psgs, default="1.6"))"""

# ╔═╡ 083bd203-e13b-45f7-934a-80cca2d9ed50
tknized = begin
	subcorp = CitableTextCorpus(filter(passage -> passagecomponent(passage.urn) == psg, corpus.passages))
	ortho = literaryGreek()
	tokenizedcorpus(subcorp, ortho)
end

# ╔═╡ 97b5f024-9646-492d-9101-ab8d6073225c
parses = parsecorpus(tknized, p)

# ╔═╡ 57a434e6-3cf0-4ead-99b7-e78183a50840
function formatTokens()
	results = ["<b>$(psg)</b> "]
	for tkn in parses
		push!(results,formatToken(tkn))
	end
	HTML(join(results, " "))
end

# ╔═╡ 411e8552-c7d7-4807-9cc1-9efbf576ac96
formatTokens()

# ╔═╡ 3a0da6d9-bcd7-4bea-827b-06d689347fc1
Pkg.status()

# ╔═╡ Cell order:
# ╟─33b04d82-dd06-4e14-a1a5-38d9eff4f39a
# ╟─405697fa-2dd2-11ec-3ed2-231cc433c3f2
# ╟─a16a811c-def6-4daf-bf0a-a8de1e913db7
# ╟─7b71dc16-0309-4855-97ed-2dddd9783c25
# ╟─411e8552-c7d7-4807-9cc1-9efbf576ac96
# ╟─2a325e68-0a41-4183-8e28-958c41faaf7f
# ╟─607e0cbb-407d-4519-9420-17f79486f02e
# ╟─c131d3a2-1d7e-4568-8978-e2b2e76528df
# ╟─a907b1cd-f8f6-49cf-a98a-2fb71d45a2b9
# ╟─d3e7cb60-08f4-4ee0-b1f3-aeccae3a7cdb
# ╟─17b290f2-3e8e-4565-a9da-13d39e9d0d4b
# ╟─083bd203-e13b-45f7-934a-80cca2d9ed50
# ╟─67475df5-1ad8-43e6-b766-aa86f7fe0b61
# ╟─97b5f024-9646-492d-9101-ab8d6073225c
# ╟─b8a4209e-cb5f-4ce3-947a-bfae77688c6e
# ╟─02013e45-03ae-45d2-b2cb-7a8b009c46ac
# ╟─57a434e6-3cf0-4ead-99b7-e78183a50840
# ╟─0c7a0ba8-e9cb-4259-9873-e62515e942dc
# ╟─a7244e41-7ae3-439e-ae51-12f915342ac2
# ╟─d69ebc92-49a4-4909-88c4-dc00433bd84b
# ╟─260a62ba-6728-4902-abc7-6033d0035e0b
# ╟─45042f08-0ecc-4868-9893-1f46278c7ab0
# ╟─ded514f6-56b9-4297-a72a-a2b9a3866bab
# ╟─5f53329f-dbb6-4af6-bfe1-01f4ca6a63da
# ╟─1f909578-1122-4fbc-a7db-b528a5bdb13b
# ╟─089b6143-21dd-44ac-95a9-672c938aa4de
# ╠═3a0da6d9-bcd7-4bea-827b-06d689347fc1
