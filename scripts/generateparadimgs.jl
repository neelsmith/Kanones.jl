using Kanones
using CitableParserBuilder
repo = pwd()
homedir = joinpath("/Users", "nsmith")

ds = Kanones.coredata(repo; atticonly = true)
outdir = joinpath(homedir,"Dropbox", "_courses","greek101-102-notes", "autoparadigms")
isdir(outdir)


verblist = [
(lex = "lsj.n84234", fname = "poiew.md"),
(lex = "lsj.n86219", fname = "prattw.md"),
(lex = "lsj.n61791", fname = "lambanw.md"),
(lex = "lsj.n56496", fname = "keleuw.md"),
(lex = "lsj.n45996", fname = "exw.md"),
(lex = "lsj.n57456", fname = "kinduneuw.md"),
(lex = "lsj.n106175", fname = "hubrizw.md"),
(lex = "lsj.n12485", fname = "apodidomi.md")
]

#lsj.n22209|gignomai
#lsj.n46613|hgeomai

for v in verblist[4:end]
    @info("Generating conjugation for $(v)...")
    md = verb_conjugation_md(LexemeUrn(v[:lex]), ds)
    open(joinpath(outdir, v[:fname]), "w") do io
        write(io, md)
    end
    @info("Wrote $(v[:fname])")
end