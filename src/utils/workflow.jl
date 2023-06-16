"""Build a Kanones dataset for literary Greek orthography, including core rules with vocabulary illustrating 
each rule, plus manually validated vocabulary from LSJ.  To include rules and stems from literary dialects
other than Attic, leave `atticonly` set to false.
$(SIGNATURES)
"""
function coredata(; atticonly = false)
    # 1. rules with demo vocab:
    lgr = joinpath(pwd(), "datasets", "literarygreek-rules")
    ionic = joinpath(pwd(), "datasets", "ionic")
    # 2. manually validated LSJ vocab:
    lsj = joinpath(pwd(), "datasets", "lsj-vocab")
    # 3. manually validated NOT in LSJ:
    extra = joinpath(pwd(), "datasets", "extra")
    atticonly ? dataset([lgr, lsj, extra]) :  dataset([lgr, ionic, lsj, extra]) 
end