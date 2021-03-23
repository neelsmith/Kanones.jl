@testset "Read rules for noun tokens from delimited text" begin
    cex = "nouninfl.h_hs2|h_hs|ης|feminine|genitive|singular|recessive"
    nounparser = Kanones.NounParser("nouns")
    rulerow = Kanones.readrulerow(nounparser, cex)
    
    @test rulerow.inflectionclass == "h_hs"
    #expectedrule = Kanones.RuleUrn("litgreek.indeclinable2")
    #@test rulerow.ruleid.collection == "litgreek"
    #@test rulerow.ruleid.objectid == "indeclinable2"
end

@testset "Read stems for noun tokens from delimited text"  begin    
    cex = "nounstems.n22502|lexent.n22502|γνωμ|masculine|h_hs|recessive|"
    nounparser = Kanones.NounParser("nouns")
    stemrow = Kanones.readstemrow(nounparser, cex)
end


