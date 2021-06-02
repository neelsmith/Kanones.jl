using Kanones
using Kanones.FstBuilder

kd = Kanones.Dataset([pwd() * "/datasets/synoptic/"])
tgt = pwd() * "/parsers/tempparser/"
fstsrc  =  pwd() * "/fst/"
parser = buildparser(kd,fstsrc, tgt)
