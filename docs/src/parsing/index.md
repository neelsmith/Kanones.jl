# Compiling and parsing



```jdocs kd
using Kanones, Kanones.FstBuilder
kd = Kanones.Dataset(pwd() * "/datasets/synoptic")
fstsrc = pwd() * "/fst/"
target = pwd() * "/parsers/testbuild/"
parser = buildparser(kd, fstsrc, target)
basename(parser)

# output

"greek.a"
```
Build a parser with the `buildparser` function.