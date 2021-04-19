using Kanones, Kanones.FstBuilder

# Build a dataset with default orthography:
ds = dataset(pwd() * "/datasets/video/")

# Build a dataset with Attic orthography:
using AtticGreek
attic = atticGreek()
atticds = dataset(pwd() * "/datasets/attic/"; ortho = attic)

# Kanones fst files
# (Another day: silently download from github)
fst = pwd() * "/fst/"

# Build parsers
lgparser = buildparser(ds, fst, pwd() * "/parsers/litgreek/")
atticparser = buildparser(atticds, fst, pwd() * "/parsers/attic/")

# Parse in Attic orthography
parses = parsetoken(atticparser, "βολêς")
analysis = parses[1]

# Rewrite in literary Greek orthography
generated = generate(analysis,ds)

# Analyze the resulting token
newtoken = generated[1]
lgparses = parsetoken(lgparser, newtoken)