# Functions for converting to/from representation of
# Greek in standard Unicode form and FST strings with
# no accents and breathings encoded as FST tokens.

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

"""Convert FST string nomral Unicode representation.
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
    end
end

"""Convert Greek string `s` to FST representation.
"""
function fstgreek(s::AbstractString)
    normed = Unicode.normalize(s, :NFKC)
    dict = compoundsdict()    
    compounds = keys(dict)
    chars = []
    for c in normed
        if c in compounds
            push!(chars, dict[c])
        else
            push!(chars, c)
        end
    end
     
    Unicode.normalize(join(chars,""), stripmark=true)
end


"""Dictionary mapping vowels with accents and/or breathings
to equivalent FST representation.
"""
function compoundsdict()
    d = Dict(
        'ἀ' => "α<sm>",
        'ἁ' => "α<ro>",
        'ἂ' => "α<sm>",
        'ἃ' => "α<ro>",
        'ἄ' => "α<sm>",
        'ἅ' => "α<ro>",
        'ἆ' => "α<sm>",
        'ἇ' => "α<ro>",

        'ᾲ' => "α<isub>",
        'ᾳ' => "α<isub>",
        'ᾴ' => "α<isub>",
        'ᾶ' => "α",
        'ᾷ' => "α<isub>",

        'ᾀ' => "α<sm><isub>",
        'ᾁ' => "α<ro><isub>",
        'ᾂ' => "α<sm><isub>",
        'ᾃ' => "α<ro><isub>",
        'ᾄ' => "α<sm><isub>",
        'ᾅ' => "α<ro><isub>",
        'ᾇ' => "α<sm><isub>",
        'ᾆ' => "α<ro><isub>",
        
        # Long vowel series:
        # hta series like alpha
        'ἠ' => "η<sm>",
        'ἡ' => "η<ro>",
        'ἢ' => "η<sm>",
        'ἣ' => "η<ro>",
        'ἤ' => "η<sm>",
        'ἥ' => "η<ro>",
        'ἦ' => "η<sm>",
        'ἧ' => "η<ro>",

        'ῂ' => "η<isub>",
        'ῃ' => "η<isub>",
        'ῄ' => "η<isub>",
        'ῆ' => "η",
        'ῇ' => "η<isub>",

        'ᾐ' => "η<sm><isub>",
        'ᾑ' => "η<ro><isub>",
        'ᾒ' => "η<sm><isub>",
        'ᾓ' => "η<ro><isub>",
        'ᾕ' => "η<sm><isub>",
        'ᾕ' => "η<ro><isub>",
        'ᾖ' => "η<sm><isub>",
        'ᾗ' => "η<ro><isub>",

        # iota series
        'ἰ' => "ι<sm>",
        'ἱ' => "ι<ro>",
        'ἲ' => "ι<sm>",
        'ἳ' => "ι<ro>",
        'ἴ' => "ι<sm>",
        'ἵ' => "ι<ro>",
        'ἶ' => "ι<sm>",
        'ἷ' => "ι<ro>",

        # upsilon series like iota
        'ὐ' => "υ<sm>",
        'ὑ' => "υ<ro>",
        'ὒ' => "υ<sm>",
        'ὕ' => "υ<ro>",
        'ὔ' => "υ<sm>",
        'ὕ' => "υ<ro>",
        'ὖ' => "υ<sm>",
        'ὗ' => "υ<ro>",

        # omega series like alpha
        'ὠ' => "ω<sm>",
        'ὡ' => "ω<ro>",
        'ὢ' => "ω<sm>",
        'ὣ' => "ω<ro>",
        'ὤ' => "ω<sm>",
        'ὥ' => "ω<ro>",
        'ὦ' => "ω<sm>",
        'ὧ' => "ω<ro>",

        'ῲ' => "ω<isub>",
        'ῳ' => "ω<isub>",
        'ῴ' => "ω<isub>",
        'ῶ' => "ω",
        'ῷ' => "ω<isub>",

        'ᾠ' => "ω<sm><isub>",
        'ᾡ' => "ω<ro><isub>",
        'ᾢ' => "ω<sm><isub>",
        'ᾣ' => "ω<ro><isub>",
        'ᾤ' => "ω<sm><isub>",
        'ᾤ' => "ω<ro><isub>",
        'ᾦ' => "ω<sm><isub>",
        'ᾧ' => "ω<ro><isub>",

        # Short vowel series:
        'ἐ' => "ε<sm>",
        'ἑ' => "ε<ro>",
        'ἒ' => "ε<sm>",
        'ἓ' => "ε<ro>",
        'ἔ' => "ε<sm>",
        'ἕ' => "ε<ro>",
        # omicron series like epislon    
        'ὀ' => "ο<sm>",
        'ὁ' => "ο<ro>",
        'ὂ' => "ο<sm>",
        'ὃ' => "ο<ro>",
        'ὄ' => "ο<sm>",
        'ὅ' => "ο<ro>",
    )
    
end