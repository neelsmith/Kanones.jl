# Generate uninflected:
# use nfkc version of stem.token
#


"""Generate vector of possible strings for correctly accented form of uninflected token identified by `analysis`.

$(SIGNATURES)

Because uninflected  forms record a full, accented string in their stem record,
all we have to do is find matching stem records, and extract their `form` members.
"""
function generateuninflected(analysis::Analysis, kd::Kanones.Dataset; ortho::T = literaryGreek()) where { T <: GreekOrthography}
    # Find stem record corresponding to this analysis.
    stems = stemsarray(kd)
    matches = filter(s -> s.lexid == analysis.lexeme, stems)
    map(stem -> stem.form,  matches)
end