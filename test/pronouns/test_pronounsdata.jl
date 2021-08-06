
@testset "Read stem record for pronoun from delimited text" begin
    cex = "pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article"
    pronounparser = Kanones.PronounParser("pronouns")
    stemrow = Kanones.readstemrow(pronounparser, cex)
    @test stemrow.stemid |> abbreviation == "pronoun.n71882a"
    @test stemrow.lexid |> abbreviation  == "lsj.n71882"
    @test stemrow.form == "ὁ"
    @test stemrow.pgender == "masculine"
    @test stemrow.pcase == "nominative"
    @test stemrow.pnumber == "singular"
    @test stemrow.pronountype == "article"
end

@testset "Read rules for noun tokens from delimited text" begin
    cex = "litgreek.pronouns1|article"
    pronounparser = Kanones.PronounParser("pronouns")
    rulerow = Kanones.readrulerow(pronounparser, cex)
    @test rulerow.ruleid |> abbreviation ==  "litgreek.pronouns1"
    @test rulerow.pronountype == "article"
end
