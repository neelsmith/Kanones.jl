# Execute this from root of Kanones repo,
# either as a script, or from within VS Code
repo = pwd()
using Dates
datesrc = now() 
yr = datesrc |> year
mo = datesrc |> month
monthday = datesrc |> day
datestr = join([yr,mo,monthday], "-")

# 1. inflectional rules
lgr = joinpath(repo, "datasets", "literarygreek-rules")
# 2. core vocab
corevocab = joinpath(repo, "datasets", "corevocab")
# 3. manually validated LSJ vocab:
lsj = joinpath(repo, "datasets", "lsj-vocab")
# 4. manually validated NOT in LSJ:
extra = joinpath(repo, "datasets", "extra")
# 5. additional vocab for Septuagint
lxx = joinpath(repo, "datasets", "septuagint")

outfile_dated = joinpath(repo, "scratch", "complutensian-$(datestr).cex")
outfile_current = joinpath(repo, "scratch", "complutensian-current.cex")

using Kanones, CitableParserBuilder
ds = dataset([lgr, corevocab, lsj, extra, lxx])

parser = kParser(ds)


tofile(parser, outfile_dated)
tofile(parser, outfile_current)



