

# 1. inflectional rules
lgr = joinpath(repo, "datasets", "literarygreek-rules")
# 2. core vocab
corevocab = joinpath(repo, "datasets", "corevocab")
# 3. additional vocab for Septuagint
lxx = joinpath(repo, "datasets", "septuagint")
using Kanones, CitableParserBuilder
ds = dataset([lgr, corevocab, lxx])

parser = kParser(ds)


