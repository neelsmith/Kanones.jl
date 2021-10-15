
@testset "Read rules for adjective tokens from delimited text" begin
    cex = "adjinfl.oshon_pos1|os_h_on_pos|ος|masculine|nominative|singular|positive|"
    adjparser = Kanones.AdjectiveParser("adjectives")
    rulerow = Kanones.readrulerow(adjparser, cex)
    @test rulerow.ruleid |> string == RuleUrn("adjinfl.oshon_pos1") |> string
    @test rulerow.inflectionclass == "os_h_on_pos"
    @test rulerow.ending == "ος"
    @test rulerow.agender == "masculine"
    @test rulerow.acase == "nominative"
    @test rulerow.anumber == "singular"
    @test rulerow.adegree == "positive"
end

@testset "Read stems for adjective tokens from delimited text"  begin    
    cex = "adjstems.n52840a|lsj.n52840|καλ|os_h_on_pos|inflectionaccented|"
    adjparser = Kanones.AdjectiveParser("adjectives")
    stemrow = Kanones.readstemrow(adjparser, cex)
    @test  stemrow.stemid |> string == StemUrn("adjstems.n52840a") |> string
    @test stemrow.lexid |> string == LexemeUrn("lsj.n52840") |> string
    @test stemrow.form == "καλ"
    @test stemrow.inflectionclass == "os_h_on_pos"
    @test stemrow.accentpersistence == "inflectionaccented"
end

#=
@testset "Read stems for irregular noun tokens from delimited text" begin
    cex = "irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun"
    irregparser = Kanones.IrregularNounParser("irregular nouns")
    stemrow = Kanones.readstemrow(irregparser, cex)

    @test  stemrow.stemid  == StemUrn("irregnoun.irregn23069a")  #|> string
    @test stemrow.lexid == LexemeUrn("lsj.n23069") 
    @test stemrow.form == nfkc("γυνή")
    @test stemrow.gender == "feminine"
    @test stemrow.gcase == "nominative"
    @test stemrow.gnumber == "singular"
   # @test stemrow.inflectionclass == "irregularnoun"
end


@testset "Read rules for irregular noun tokens from delimited text" begin
    cex = "irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular"
    nounparser = Kanones.IrregularNounParser("nouns")
    @test_broken  Kanones.readrulerow(nounparser, cex)
    #=
    rulerow = Kanones.readrulerow(nounparser, cex)
    @test rulerow.ruleid == RuleUrn("irregnoun.irregn23069a") 
    @test rulerow.inflectionclass == "irregularnoun"
    @test rulerow.ending == ""
    @test rulerow.ngender == "feminine"
    @test rulerow.ncase == "nominative"
    @test rulerow.nnumber == "singular"
    =#    
end
=#