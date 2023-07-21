
"""Normalize string `s` for processing with Kanones
by making string all lowercase and flipping any grave
accents to acute.
"""
function knormal(s, ortho = literaryGreek())
    @debug("Normalize $(s)")
    lc = nfkc(s) |> lowercase  
    acc1 = PolytonicGreek.flipaccent(lc, ortho)
    acc2 = dropsecondaccent(acc1, ortho)
    acc2
end