# Functions for converting to/from representation of
# Greek in standard Unicode form and FST strings with
# no accents and breathings encoded as FST tokens.

"""Add smooth breathing to a vowel.

$(SIGNATURES)
"""
function addsmooth(vowel::AbstractString)
    dict = Dict(
        "α" => "ἀ",
        "ε" => "ἐ",
        "ι" => "ἰ",
        "ο" => "ὀ",
        "υ" => "ὐ",
        "η" => "ἠ",
        "ω" => "ὠ",
    )
    replacement = dict[vowel]
    replacement
end


"""Add rough breathing to a vowel.

$(SIGNATURES)
"""
function addrough(vowel::AbstractString)
    dict = Dict(
        "α" => "ἁ",
        "ε" => "ἑ",
        "ι" => "ἱ",
        "ο" => "ὁ",
        "υ" => "ὑ",
        "η" => "ἡ",
        "ω" => "ὡ",
    )
    dict[vowel]
end

"""Convert FST string to Unicode representation of Greek.

$(SIGNATURES)
"""
function greekfromfst(fst::AbstractString)
    # Check size of matches...
    # Assuming re actually matched and we have only one breathing.
    if occursin("<sm>", fst)
        smoothre = r"(.)<sm>"
        matches = eachmatch(smoothre, fst) |> collect
        vowel = matches[1].captures[1]
        ucode = addsmooth(vowel)
        replace(fst, vowel * "<sm>" => ucode)

    elseif occursin("<ro>", fst)
        roughre = r"(.)<ro>"
        matches = eachmatch(roughre, fst) |> collect
        vowel = matches[1].captures[1]
        ucode = addrough(vowel)
        replace(fst, vowel * "<ro>" => ucode)
    else
        fst
    end
end

"""Convert Greek string `s` to FST representation.

$(SIGNATURES)

"""
function fstgreek(s::AbstractString, ortho::T = literaryGreek()) where {T <: GreekOrthography}
    normed = nfkc(s) 
    rmaccents(normed, ortho)
end

