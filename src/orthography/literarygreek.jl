
"""Mappings for multiple words written as a single word in a given orthography.
Includes both crasis and attached enclitic forms.
"""
function crasis(s, ortho::T) where T <: OrthographicSystem
    @warn("`crasis` not implemented for othography of type $(T)")
end


"""Mappings for multiple words written as a single word in `LiteraryGreekOrthography`.
Includes both crasis and attached enclitic forms.
"""
function crasis(s, ortho::LiteraryGreekOrthography)
    if haskey(lg_crasis, s)
        map(subs -> knormal(subs, ortho), lg_crasis[s])
    else
        [s]
    end
end

"""Dictionary for multiple words written as a single word in `LiteraryGreekOrthography`."""
lg_crasis = Dict(
    
    knormal("ἔγωγε") => ["ἔγω", "γε"],

    knormal("ἐπειδὰν") => ["ἐπειδή", "ἄν"],

    knormal("κἀγὼ") => ["καὶ", "ἐγώ"],
    knormal("κἀκεῖ") => ["καὶ", "ἐκεῖ"],
    knormal("κἀκεῖνος") => ["καὶ", "ἐκεῖνος"],
    
    knormal("τἀληθῆ") => ["τὰ", "ἀληθῆ"],
    knormal("τἆλλα") => ["τὰ", "ἄλλα"]
)