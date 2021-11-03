
@testset "Write fst rules for uninflected tokens" begin
    cex = "litgreek.indeclinable2|conjunction"
    uninfl = Kanones.UninflectedParser("uninflected")
    rulerow = Kanones.readrulerow(uninfl, cex)
    expected = "<conjunction><uninflected><u>litgreek\\.indeclinable2</u>"


    @test FstBuilder.fst(rulerow) == expected 
end

@testset "Write fst lexicon for uninflected stems" begin
    cex = "uninflectedstems.uninf2|lsj.n51951|καί|conjunction|"
    uninfl = Kanones.UninflectedParser("uninflected")
    stemrow = Kanones.readstemrow(uninfl, cex)
    expected = "<u>uninflectedstems\\.uninf2</u><u>lsj\\.n51951</u>και<uninflected><conjunction>"
    @test FstBuilder.fst(stemrow) == expected
end