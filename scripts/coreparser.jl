using Kanones
using Dates


# Build a parser with demo vocab and manually validated vocab from LSJ.
function coredata()
    # 1. demo vocab:
    lgr = joinpath(pwd(), "datasets", "literarygreek-rules")
    # 2. manually validated LSJ vocab:
    lsj = joinpath(pwd(), "datasets", "lsj-vocab")
    # 3. manually validated NOT in LSJ:
    extra = joinpath(pwd(), "datasets", "extra")
    dataset([lgr, lsj, extra])
end


# Compose a single CSV file instantiating a parser from a FilesDataset
function writedataset(ds::Kanones.FilesDataset)
    basename = string("literarygreek-core-", today())
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

    currentfile = joinpath(pwd(), "parsers", "current.csv")
    cp(outfile, currentfile)
end

