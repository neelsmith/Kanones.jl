

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
end