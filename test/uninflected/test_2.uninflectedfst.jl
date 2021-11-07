
@testset "Write fst rules for uninflected tokens" begin
    cexsrc = "uninflectedrules.indeclinable2|conjunction"
    uninflio = Kanones.UninflectedIO("uninflected i/o")
    rulerow = Kanones.readrulerow(uninflio, cexsrc)
    expected = "<conjunction><uninflected><u>uninflectedrules\\.indeclinable2</u>"


    @test FstBuilder.fst(rulerow) == expected 
end

@testset "Write fst lexicon for uninflected stems" begin
    cexsrc = "uninflectedstems.uninf2|lsj.n51951|καί|conjunction|"
    uninfl = Kanones.UninflectedIO("uninflected")
    stemrow = Kanones.readstemrow(uninfl, cexsrc)
    expected = "<u>uninflectedstems\\.uninf2</u><u>lsj\\.n51951</u>και<uninflected><conjunction>"
    @test FstBuilder.fst(stemrow) == expected
end