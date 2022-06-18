

function knormal(s, ortho = literaryGreek())
    lc = nfkc(s) |> lowercase  
    PolytonicGreek.flipaccent(lc, ortho)
end