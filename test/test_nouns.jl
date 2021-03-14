


@testset "Read rules for noun tokens from delimited text" begin
    cex = "nouninfl.h_hs2|h_hs|ης|feminine|genitive|singular|"
    nounparser = FstBuilder.NounParser("nouns")
    rulerow = FstBuilder.readrulerow(nounparser, cex)
    #@test rulerow.infltype == "conjunction"
    #expectedrule = Kanones.RuleUrn("litgreek.indeclinable2")
    #@test rulerow.ruleid.collection == "litgreek"
    #@test rulerow.ruleid.objectid == "indeclinable2"
end
