
function debugaccent(raw, pattrn, ortho)
    accented = accentword(raw, pattrn, ortho)
    @info("Before/after accent", raw, accented)
    if occursin("nothing", accented)
        throw(DomainError("Bad result trying to accent source $(raw)"))
    end
    accented
end