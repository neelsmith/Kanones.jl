
@testset "Read rules for uninflected tokens from delimited text" begin
    cex = "litgreek.indeclinable2|conjunction"
    uninfl = FstBuilder.UninflectedParser("uninflected")
    rulerow = FstBuilder.readrulerow(uninfl, cex)
    @test rulerow.infltype == "conjunction"
    expectedrule = Kanones.RuleUrn("litgreek.indeclinable2")
    @test rulerow.ruleid.collection == "litgreek"
    @test rulerow.ruleid.objectid == "indeclinable2"
end

@testset "Write fst rules for uninflected tokens" begin
    cex = "litgreek.indeclinable2|conjunction"
    uninfl = FstBuilder.UninflectedParser("uninflected")
    rulerow = FstBuilder.readrulerow(uninfl, cex)
    expected = "<conjunction><uninflected><u>litgreek\\.indeclinable2</u>"
    @test FstBuilder.fst(rulerow) == expected 
end


@testset "Read stems for uninflected tokens from delimited text" begin
    cex = "uninflectedstems.uninf2|lsj.n51951|καί|conjunction|"
    uninfl = FstBuilder.UninflectedParser("uninflected")
    stemrow = FstBuilder.readstemrow(uninfl, cex)

    actualstemid = stemrow.stemid
    @test isa(actualstemid, StemUrn)
    expectedstemid = StemUrn("uninflectedstems.uninf2")
    @test expectedstemid.collection == actualstemid.collection
    @test expectedstemid.objectid == actualstemid.objectid

    actuallexid = stemrow.lexid
    @test isa(actuallexid, LexemeUrn)
    expectedlexid = LexemeUrn("lsj.n51951")
    @test expectedlexid.collection == actuallexid.collection
    @test expectedlexid.objectid == actuallexid.objectid

     
    @test stemrow.form == "και"
    @test stemrow.stemcategory == "conjunction"
end


@testset "Write fst lexicon for uninflected stems" begin
    cex = "uninflectedstems.uninf2|lsj.n51951|καί|conjunction|"
    uninfl = FstBuilder.UninflectedParser("uninflected")
    stemrow = FstBuilder.readstemrow(uninfl, cex)
    expected = "<u>uninflectedstems\\.uninf2</u><u>lsj\\.n51951</u>και<uninflected><conjunction>"
    @test FstBuilder.fst(stemrow) == expected
    #@test FstBuilder.fst(rulerow) == expected 
end