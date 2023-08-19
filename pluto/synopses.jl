### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ bbd87e01-007e-4adc-82ab-4d8face91fbc
begin
	#=
	
	
	using PlutoUI
	=#
	using Pkg
	Pkg.activate(dirname(pwd()))
	using Kanones
	using CitableParserBuilder
	using Markdown
	
end

# ╔═╡ 225514e4-3e9d-11ee-3c14-99cdc63944a8
md"# Synopses"

# ╔═╡ 7acd599b-20f9-46cd-b7ae-e59670192a6f
md"""
> **TBD**
>
> - Work off a published version of Kanones instead of live repo
> - Add a user selectable menu of verbs
> - Add user-selectable settings for person, number
"""

# ╔═╡ f1271a21-bd00-4a2a-9300-f8fc7ea439b6
verbu = LexemeUrn("lsj.n84234")

# ╔═╡ af701fbe-4cec-4079-8d86-d6e24f466fa8
repo = pwd() |> dirname


# ╔═╡ 574acb6c-eeb2-4dcc-aa55-20e0df9501b4
ds = Kanones.coredata(repo; atticonly = true)

# ╔═╡ adc67d81-a8ce-4453-94ba-1f95eebcff06
md_synopsis(verbu, ds, gmpPerson("third"), gmpNumber("singular")) |> Markdown.parse

# ╔═╡ Cell order:
# ╠═bbd87e01-007e-4adc-82ab-4d8face91fbc
# ╟─225514e4-3e9d-11ee-3c14-99cdc63944a8
# ╟─7acd599b-20f9-46cd-b7ae-e59670192a6f
# ╠═f1271a21-bd00-4a2a-9300-f8fc7ea439b6
# ╟─af701fbe-4cec-4079-8d86-d6e24f466fa8
# ╠═574acb6c-eeb2-4dcc-aa55-20e0df9501b4
# ╠═adc67d81-a8ce-4453-94ba-1f95eebcff06
