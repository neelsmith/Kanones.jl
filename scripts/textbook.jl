using Kanones
ds = Kanones.coredata(; atticonly = true)
lsjdict = Kanones.lsjid_dict()

vocab = [
    "κελευω",
    "ποιεω",
    "δεικνυμι"
]
vocablex = [lsjdict[lemma] for lemma in vocab]

pplists = [Kanones.principalparts(lex, ds) for lex in vocablex]

join(join.(pplists, ","), "\n") |> println


fullconj = [Kanones.verb_conjugation_md(lex, ds) for lex in vocablex]

#####
# Debug aor. pass. imptvforms

#  imperativeconjugation_md(t::GMPTense, v::GMPVoice, lex::LexemeUrn, kd::Kanones.FilesDataset)
#=
debugmd = Kanones.imperativeconjugation_md(gmpTense("aorist"), gmpVoice("passive"), vocablex[1], ds)


debugmd |> println



imptvforms = filter(f -> f isa GMFFiniteVerb && gmpMood(f) == gmpMood("imperative") && gmpVoice(f) == gmpVoice("passive") && gmpTense(f) == gmpTense("aorist"), allforms())

# generate(lex, formurn(f), ds),", "

Kanones.generate(vocablex[1], formurn(imptvforms[1]), ds)
=#