using Kanones



ds = Kanones.coredata(atticonly = true)
inflindex = lexemeclassindex(ds)

#=
1. Find vocab in corpus by pos, sorted by freq
2. Find infl types for each
=#