using Unicode

o = "ῳ"
decomp = Unicode.normalize(o, :NFKD)
comp = Unicode.normalize(o, :NFKC)

ho = "ᾡ"
deho = Unicode.normalize(ho, :NFKD)
#=
julia> comp == decomp
false

julia> length(comp)
1

julia> length(decomp)
2
=#
