
@testset "Read rules for adjective tokens from delimited text" begin
    cexsrc = "adjinfl.oshon_pos1|os_h_on_pos|ος|masculine|nominative|singular|positive|"
    adjectiveio = Kanones.AdjectiveIO("adjectives")
    rule = Kanones.readrulerow(adjectiveio, cexsrc)
    @test rule.ruleid |> string == RuleUrn("adjinfl.oshon_pos1") |> string
    @test rule.inflectionclass == "os_h_on_pos"
    @test rule.ending == "ος"
    @test rule.agender == GMPGender(1)
    @test rule.acase == GMPCase(1)
    @test rule.anumber == GMPNumber(1)
    @test rule.adegree == GMPDegree(1)
end

@testset "Read stems for adjective tokens from delimited text"  begin    
    cexsrc = "adjstems.n52840a|lsj.n52840|καλ|os_h_on_pos|inflectionaccented|"
    adjectiveio = Kanones.AdjectiveIO("adjectives")
    stem = Kanones.readstemrow(adjectiveio, cexsrc)
    @test  stem.stemid |> string == StemUrn("adjstems.n52840a") |> string
    @test stem.lexid |> string == LexemeUrn("lsj.n52840") |> string
    @test stem.form == "καλ"
    @test stem.inflectionclass == "os_h_on_pos"
    @test stem.accentpersistence == "inflectionaccented"
end


@testset "Read stems for irregular adjective tokens from delimited text" begin
    cexsrc = "irregadj.n79904a|lsj.n79904|πᾶς|masculine|nominative|singular|positive|irregularadjective"
    irregadjio = Kanones.IrregularAdjectiveIO("irregular adjs r/w")
    stem = Kanones.readstemrow(irregadjio, cexsrc)

    @test  stem.stemid  == StemUrn("irregadj.n79904a") 
    @test stem.lexid == LexemeUrn("lsj.n79904") 
    @test stem.form == nfkc("πᾶς")
    @test stem.adjgender == GMPGender(1)
    @test stem.adjcase == GMPCase(1)
    @test stem.adjnumber == GMPNumber(1)
    @test stem.adjdegree == GMPDegree(1)
   # @test stemrow.inflectionclass == "irregularnoun"
end
