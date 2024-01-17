LAST_SORT = 40000

"""Sort lines of a delimited-text file by LSJ number located in column `col`.  
$(SIGNATURES)
"""
function sortbylsj(f; col = 2)
    dataset = readdlm(f,'|')
    sortable = []
    for i = 2:size(dataset,1)
        ln = dataset[i,:]
        @debug("LOOK AT", ln[col])
        if startswith(ln[col], "lsj.n")
            trimtrailingalpha = replace(ln[col], r"[a-z]$" => "")
            intkey = parse(Int64, replace(trimtrailingalpha, "lsj.n" => ""))
            @debug("INTKEY", intkey)
            push!(sortable, (intkey, ln))
        else
            push!(sortable, (LAST_SORT,ln))
        end
    end
    @debug("SORTABLE",sortable)

    sorted = map(pr -> pr[2], sort(sortable))
    lines = map(v -> join(v,"|"), sorted)
    contents = string(join(dataset[1,:],"|"), "\n\n", join(lines, "\n"))
    contents
end


"""Overwrite file `f` with contents sorted by LSJ number located in column `col`.
$(SIGNATURES)
"""
function sortbylsj!(f; col = 2)
    contents = sortbylsj(f, col = col)
    open(f,"w") do io
       write(io,contents)
    end
end



"""Overwrite `.cex` files in `dir` with contents sorted by LSJ number located in column `col`.
$(SIGNATURES)
"""
function sortdirbylsj!(dir; col = 2)
    cexfiles = glob("*.cex", dir)
    for f in cexfiles
        @info("sorting $(f)")
        sortbylsj!(f, col = col)
    end
end




"""Create a dictionary with stripped (reliably typable) versions of lemma strings as keys to `LexemeUrn`s for
lexemes in the `lsj` dataset. Note that some distinct lemmata may reduce to a single stripped versions, only one of which will appear in this convenience data.

$(SIGNATURES)
"""
function lsjid_dict(repodir = pwd())
    lsjfile = joinpath(repodir, "datasets", "lsj-vocab", "lexemes", "lsj.cex")
    iddict = Dict()
    idpairs = filter(ln -> !isempty(ln), readlines(lsjfile))
    for pr in idpairs[2:end]
        pieces = split(pr, "|")
        keyval = Unicode.normalize(pieces[2], stripmark = true)
        iddict[keyval]= LexemeUrn(pieces[1])
    end
    iddict
end



"""Create a dictionary with stripped (reliably typable) versions of lemma strings as keys to `LexemeUrn`s for
lexemes in both the `lsj` and `lsjx` datasets.  Note that some distinct lemmata may reduce to a single stripped versions, only one of which will appear in this convenience data.

$(SIGNATURES)
"""
function lexid_dict(repodir = pwd())
    iddict = lsjid_dict(repodir)
    lsjxfile = joinpath(repodir, "datasets", "lsj-vocab", "lexemes", "lsjx.cex")
    idpairs = filter(ln -> !isempty(ln), readlines(lsjxfile))
    for pr in idpairs[2:end]
        pieces = split(pr, "|")
        keyval = Unicode.normalize(pieces[2], stripmark = true)
        iddict[keyval]= LexemeUrn(pieces[1])
    end
    iddict
end