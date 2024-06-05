using Kanones
using CitableParserBuilder
using Unicode

kd = Kanones.coredata(; atticonly = true)


lexidfile = joinpath(pwd(), "datasets", "lsj-vocab", "lexemes", "lsj.cex")
pairs = filter(ln -> !isempty(ln), readlines(lexidfile))
lexiddict = Dict()

for pr in pairs[2:end]
    pieces = split(pr, "|")
    keyval = Unicode.normalize(pieces[2], stripmark = true)
    lexiddict[keyval]= LexemeUrn(pieces[1])
end


