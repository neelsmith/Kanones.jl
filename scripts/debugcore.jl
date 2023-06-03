using Kanones

function coredata()
    # 1. demo vocab:
    lgr = joinpath(pwd(), "datasets", "literarygreek-rules")
    # 2. manually validated LSJ vocab:
    lsj = joinpath(pwd(), "datasets", "lsj-vocab")
    # 3. manually validated NOT in LSJ:
    extra = joinpath(pwd(), "datasets", "extra")
    dataset([lgr, lsj, extra])
end

parser = stringParser(coredata())


parsetoken("πόλις", parser)