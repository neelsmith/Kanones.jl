using Kanones.FstBuilder
using Kanones


fstsrc  =  pwd() * "/fst/"

synoptic = pwd() * "/datasets/synoptic/"
core = pwd() * "/datasets/core/"

datasets = [core, synoptic]


Kanones.Dataset(datasets)


tgt = pwd() * "/parsers/comboparser/"
parser = buildparser(kd,fstsrc, tgt)
