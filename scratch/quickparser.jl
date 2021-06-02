using Kanones.FstBuilder
using Kanones


fstsrc  =  pwd() * "/fst/"

synoptic = pwd() * "/datasets/synoptic/"
core = pwd() * "/datasets/core/"
lysias = pwd()  * "/datasets/lysias/"

datasets = [core, synoptic, lysias]


kd = Kanones.Dataset(datasets)


tgt = pwd() * "/parsers/comboparser3/"
parser = buildparser(kd,fstsrc, tgt)

coreex = "ἀπό"
synex = "γνώμη"
lysex = "τέχνης"

parsetoken(parser, coreex)
parsetoken(parser, synex)
parsetoken(parser, lysex)