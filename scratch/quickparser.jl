using Kanones
using Kanones.FstBuilder


fstsrc  =  pwd() * "/fst/"

synoptic = pwd() * "/datasets/synoptic/"
core = pwd() * "/datasets/core/"

datasets = [core, synoptic]


Kanones.Dataset(datasets)


tgt = pwd() * "/parsers/tempparser/"
parser = buildparser(kd,fstsrc, tgt)
