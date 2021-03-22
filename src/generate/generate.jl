

function generate(analysis::Analysis)
    # is token == stem.form + rule.ending ?
    #
    # treatment depends on PoS.
    # So get that from column 1 of form.
    #=
    struct Analysis
        token::AbstractString
        lexeme::LexemeUrn
        form::FormUrn
        rule::RuleUrn
        stem::StemUrn
    end
    =#
    formcolumns = split(accpl.form.objectid,"")
    dict = valuedict(pospairs)
    # Switch on this value:
    pos = dict[parse(Int64, formcolumns[1])]
end