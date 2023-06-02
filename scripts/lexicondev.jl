using CitableBase, CitableCorpus
using Orthography, PolytonicGreek
using CitableParserBuilder, Kanones

using DataFrames



src = "/Users/nsmith/Dropbox/_kanones/literarygreek-all-2023-05-25.csv"
parser = dfParser(read(src))



hdturl = "https://raw.githubusercontent.com/neelsmith/eagl-texts/wip/texts/herodotus.cex"

corpus =  fromcex(hdturl, CitableTextCorpus, UrlReader)
ortho = literaryGreek()
histo = corpus_histo(corpus, ortho, filterby = LexicalToken())
histocoll = collect(histo)

n = 200
map(pr -> string(pr[1], " ", pr[2]), histocoll[1:n]) .|> println


@time analyzedlexical = parsecorpus(tokenizedcorpus(corpus,ortho, filterby = LexicalToken()), parser)