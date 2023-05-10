
"""Normalize string `s` for processing with Kanones
by making string all lowercase and flipping any grave
accents to acute.
"""
function knormal(s, ortho = literaryGreek())
    lc = nfkc(s) |> lowercase  
    PolytonicGreek.flipaccent(lc, ortho)
end