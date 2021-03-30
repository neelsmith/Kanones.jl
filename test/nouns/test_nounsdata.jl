@testset "Read rules for noun tokens from delimited text" begin
    cex = "nouninfl.h_hs2|h_hs|ης|feminine|genitive|singular|recessive"
    nounparser = Kanones.NounParser("nouns")
    rulerow = Kanones.readrulerow(nounparser, cex)
    @test rulerow.ruleid |> abbreviation == RuleUrn("nouninfl.h_hs2") |> abbreviation
    @test rulerow.inflectionclass == "h_hs"
    @test rulerow.ending == "ης"
    @test rulerow.ngender == "feminine"
    @test rulerow.ncase == "genitive"
    @test rulerow.nnumber == "singular"
end

@testset "Read stems for noun tokens from delimited text"  begin    
    cex = "nounstems.n22502|lexent.n22502|γνωμ|feminine|h_hs|recessive|"
    nounparser = Kanones.NounParser("nouns")
    stemrow = Kanones.readstemrow(nounparser, cex)
    @test  stemrow.stemid |> abbreviation == StemUrn("nounstems.n22502") |> abbreviation
    @test stemrow.lexid |> abbreviation == LexemeUrn("lexent.n22502") |> abbreviation
    @test stemrow.form == "γνωμ"
    @test stemrow.gender == "feminine"
    @test stemrow.inflectionclass == "h_hs"
    @test stemrow.accentpersistence == "recessive"
end

