"""Build a Kanones dataset for literary Greek orthography, including core rules with vocabulary illustrating 
each rule, plus manually validated vocabulary from LSJ.  To include rules and stems from literary dialects
other than Attic, leave `atticonly` set to false.
$(SIGNATURES)
"""
function coredata(repo = pwd(); atticonly = false)
    # 1. rules with demo vocab:
    lgr = joinpath(repo, "datasets", "literarygreek-rules")
    ionic = joinpath(repo, "datasets", "ionic")
    homeric = joinpath(repo, "datasets", "homeric")
    # 2. manually validated LSJ vocab:
    lsj = joinpath(repo, "datasets", "lsj-vocab")
    # 3. manually validated NOT in LSJ:
    extra = joinpath(repo, "datasets", "extra")
    atticonly ? dataset([lgr, lsj, extra]) :  dataset([lgr, ionic, homeric, lsj, extra]) 
end

"""Build a parser for the core dataset for literary Greek orthography.
$(SIGNATURES)
"""
function coreparser(repo = pwd(); atticonly = false)
    coredata(repo; atticonly = atticonly) |> KanonesStringParser
end