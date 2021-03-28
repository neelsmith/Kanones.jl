# Managing Kanones datasets



- You manage rules and stems
- Kanones has a required directory structure for data files

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