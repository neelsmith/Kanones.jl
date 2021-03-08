
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
        'ἀ' => "α<sm>"
    )
    d
end