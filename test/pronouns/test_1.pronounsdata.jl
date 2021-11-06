
@testset "Read stems for pronoun tokens from delimited text" begin
    cexsrc = "pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article"
    pronounio = Kanones.PronounIO("pronouns")
    stemrow = Kanones.readstemrow(pronounio, cexsrc)
    @test stemrow.stemid |> string == "pronoun.n71882a"
    @test stemrow.lexid |> string  == "lsj.n71882"
    @test stemrow.form == "ὁ"
    @test stemrow.pgender == "masculine"
    @test stemrow.pcase == "nominative"
    @test stemrow.pnumber == "singular"
    @test stemrow.pronountype == "article"
end

@testset "Read rules for pronoun tokens from delimited text" begin
    cex = "litgreek.pronouns1|article"
    pronounio = Kanones.PronounIO("pronouns")
    rulerow = Kanones.readrulerow(pronounio, cex)
    @test rulerow.ruleid |> string ==  "litgreek.pronouns1"
    @test rulerow.pronountype == "article"
end
