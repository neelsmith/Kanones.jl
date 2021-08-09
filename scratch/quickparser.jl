using Kanones.FstBuilder
using Kanones


fstsrc  =  pwd() * "/fst/"

coreinfl = pwd() * "/datasets/core-infl/"
corevocab = pwd() * "/datasets/core-vocab/"
lysias = pwd()  * "/datasets/lysias/"

datasets = [corevocab, coreinfl, lysias]

kd = Kanones.Dataset(datasets)


tgt = pwd() * "/parsers/comboparser/"
parser = buildparser(kd,fstsrc, tgt)


#=
coreex = "ἀπό"
synex = "γνώμη"
lysex = "τέχνης"

parsetoken(parser, coreex)
parsetoken(parser, synex)
parsetoken(parser, lysex)
=#

# All words in Lysias
f = "test/testdata/wordlist.txt"
parses = parselistfromfile(parser, f)