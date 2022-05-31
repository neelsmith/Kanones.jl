
function debugaccent(raw, pattrn, ortho)
    accented = accentword(raw, pattrn, ortho)
    @debug("Before/after", raw, accented)
    if occursin("nothing", accented)
        throw(DomainError("Bad result from source $(raw)"))
    end
    accented
end