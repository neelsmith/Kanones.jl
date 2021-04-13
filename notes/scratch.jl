using Kanones
using Kanones.FstBuilder

kd = Kanones.Dataset(pwd() * "/datasets/synoptic/")
tgt = pwd() * "/parsers/tempparser/"
fstsrc  =  pwd() * "/fst/"
parser = buildparser(kd,fstsrc, tgt)


tokens = []
# Make a list of tokens
for i in 1:100
    push!(tokens, "καί")
    push!(tokens, "ὦ")
    push!(tokens, "δέ")
    push!(tokens, "ἐπί")
    push!(tokens, "νῦν")
    push!(tokens, "δύο")
    push!(tokens, "NOTGREEK")
    push!(tokens, "καὶ")
    push!(tokens, "και")
    push!(tokens, "δὲ")
    push!(tokens, "δε")
    push!(tokens, "νυν")
    push!(tokens, "bad")
end

@time begin
    for t in tokens
        parsetoken(parser, t)
    end
end