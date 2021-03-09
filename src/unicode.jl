
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
        # iota series like alpha
        # upsilon series like alpha
        # omega series like alpha

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