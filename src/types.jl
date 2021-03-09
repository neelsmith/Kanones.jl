

abstract type Stem end
abstract type StemType end
abstract type Rule end
abstract type RuleType end


struct Analysis
    tkn::AbstractString
    lexeme::LexemeUrn
    form::AbstractString
    rule::RuleUrn
    stem::StemUrn
end
#abstract type Analysis end=#
#abstract type AnalysisType end
#=
struct Uninflected <: AnalysisType 

end
=#
