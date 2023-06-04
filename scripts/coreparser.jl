using Kanones
using Dates


# Build a parser with validated vocab from LSJ and hypothesized dataset
# from an LSJMining dataset in adjacent directory.
function alllitgreek()
    # 1. demo vocab:
    lgr = joinpath(pwd(), "datasets", "literarygreek-rules")
    # 2. manually validated LSJ vocab:
    lsj = joinpath(pwd(), "datasets", "lsj-vocab")
    # 3. manually validated NOT in LSJ:
    extra = joinpath(pwd(), "datasets", "extra")
    # 4. hypothesized data from LSJMining
    lsjx = joinpath("..", "LSJMining.jl", "kanonesdata","lsjx")
    dataset([lgr, lsj, extra, lsjx])
end




# Build a parser with demo vocab and manually validated vocab from LSJ.
function coredata()
    # 1. rules with demo vocab:
    lgr = joinpath(pwd(), "datasets", "literarygreek-rules")
    ionic = joinpath(pwd(), "datasets", "ionic")
    # 2. manually validated LSJ vocab:
    lsj = joinpath(pwd(), "datasets", "lsj-vocab")
    # 3. manually validated NOT in LSJ:
    extra = joinpath(pwd(), "datasets", "extra")
    dataset([lgr, ionic, lsj, extra])
end


# Compose a single CSV file instantiating a parser from a FilesDataset
# use "core" or "all" for dslabel
function writedataset(ds::Kanones.FilesDataset, dslabel)
    basename = string("literarygreek-$(dslabel)-", today())
    outputdir = joinpath(pwd(), "scratch", basename)
    mkpath(outputdir)
    writecsv(ds, outputdir)outputdir

    lines = ["Token,Lexeme,Form,Stem,Rule"]
    outfiles = readdir(outputdir)
    csvfiles = filter(fname -> endswith(fname, ".csv"), outfiles)
    for csvfile in csvfiles
        lines = vcat(lines, readlines(joinpath(outputdir, csvfile)))
    end
    outfile = joinpath(pwd(), "parsers", basename * ".csv")
    csv = join(lines, "\n") * "\n"
    open(outfile, "w") do io
        write(io, csv)
    end

    currentfile = joinpath(pwd(), "parsers", "current-$(dslabel).csv")
    cp(outfile, currentfile)
end


ds = coredata()

# For interactive testing:
parser = stringParser(ds)

parsetoken("πᾶς", parser) |> println