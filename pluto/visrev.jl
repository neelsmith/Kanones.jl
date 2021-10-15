### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ cdfcb4b9-1e30-4c01-8852-98f047846205
begin
    import Pkg
	Pkg.add(url="https://github.com/neelsmith/Kanones.jl#dev")
	Pkg.add("CitableCorpus")
	Pkg.add(name="PolytonicGreek", version="0.13")
	using Kanones, Kanones.FstBuilder
	using CitableCorpus
	Pkg.status()
end

# ╔═╡ 64d102d4-63e5-4b85-8f2d-6e938755238b
md"""
This is **not** a reproducible notebook.
"""

# ╔═╡ 882d69a8-2dcc-11ec-052a-7741ac863b51
md"""# Visual review of parsing Lysias"""

# ╔═╡ d5065c48-3e34-4953-97c0-dbe3b05acdcc
root = pwd() |> dirname

# ╔═╡ e4717c9d-a20b-41b7-8f8f-add17922245e
md"""

---

> under the hood
"""

# ╔═╡ eb456b70-3613-4a54-86e0-23f91637b509
md"Build a Lysian parser from the root of the Kanones repo."

# ╔═╡ 6ec1f119-b04e-4105-8eaf-ef13bd39ab23
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

# ╔═╡ 1d7a2850-9282-4c05-ae7d-3370fd14b57a
p = lysiasparser(root)

# ╔═╡ f0c7638f-93d0-4557-836c-655804bc7142
md"Load a corpus of Lysias"

# ╔═╡ 232afdf2-e57d-4cdd-a42b-e93bcc59a0a0
corpus = begin
	f = joinpath(root, "scratch", "lysias1.cex")
	read(f) |> corpus_fromcex
end

# ╔═╡ Cell order:
# ╟─64d102d4-63e5-4b85-8f2d-6e938755238b
# ╠═cdfcb4b9-1e30-4c01-8852-98f047846205
# ╟─882d69a8-2dcc-11ec-052a-7741ac863b51
# ╟─d5065c48-3e34-4953-97c0-dbe3b05acdcc
# ╟─e4717c9d-a20b-41b7-8f8f-add17922245e
# ╟─eb456b70-3613-4a54-86e0-23f91637b509
# ╟─1d7a2850-9282-4c05-ae7d-3370fd14b57a
# ╟─6ec1f119-b04e-4105-8eaf-ef13bd39ab23
# ╟─f0c7638f-93d0-4557-836c-655804bc7142
# ╟─232afdf2-e57d-4cdd-a42b-e93bcc59a0a0
