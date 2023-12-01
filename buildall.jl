using Kanones

@info("Starting to build parser...")
repo = pwd()
	
# 1. rules with demo vocab:
lgr = joinpath(repo, "datasets", "literarygreek-rules")
ionic = joinpath(repo, "datasets", "ionic")
homeric = joinpath(repo, "datasets", "homeric")
# 2. manually validated LSJ vocab:
lsj = joinpath(repo, "datasets", "lsj-vocab")
# 3. manually validated NOT in LSJ:
extra = joinpath(repo, "datasets", "extra")
# 4. Optionally, auto-quarried data from LSJ:
lsjmining = joinpath(dirname(repo), "LSJMining.jl", "kanonesdata", "lsjx")

# Gather data:
ds = dataset([lgr, ionic, homeric, lsj, extra, lsjmining]) 
@info("Created comprehensive data set.")


doit = false
if doit
    @info("Compiling parser...")
    parser = stringParser(ds)
    @info("Done compiling.")
    parserfile = "massiveparser.cex"
    Kanones.tofile(parser, parserfile)
    @info("Wrote parser to $(parserfile)")
end
