
"""Wrapper around `PolytonicGreek`'s `accentword` function
for debugging.
"""
function debugaccent(raw, pattrn, ortho)
    @debug("DEbugging accent $(raw) / $(pattrn)")
    accented = accentword(raw, pattrn, ortho)
    @debug("Before/after accent", raw, accented)
    if occursin("nothing", accented)
        throw(DomainError("Bad result trying to accent source $(raw)"))
    end
    if countaccents(accented, ortho) == 0
        @warn("UNABLE TO ACCENT: ", accented)
    end
    accented
end