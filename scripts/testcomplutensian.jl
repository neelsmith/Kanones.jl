

# 1. core
lgr = joinpath(repo, "datasets", "literarygreek-rules")
# 2. additional vocab for Septuagint
lxx = joinpath(repo, "datasets", "septuagint")
using Kanones, CitableParserBuilder
ds = dataset([lgr, lxx])

parser = kParser(ds)


