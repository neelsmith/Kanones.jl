
@testset "Read rules for uninflected tokens from delimited text" begin
    cex = "litgreek.indeclinable2|conjunction"
    uninfl = Kanones.UninflectedParser("uninflected")
    rulerow = Kanones.readrulerow(uninfl, cex)
    @test rulerow.infltype == "conjunction"
    expectedrule = RuleUrn("litgreek.indeclinable2")
    @test rulerow.ruleid.collection == "litgreek"
    @test rulerow.ruleid.objectid == "indeclinable2"
end



@testset "Read stems for uninflected tokens from delimited text" begin
    cex = "uninflectedstems.uninf2|lsj.n51951|καί|conjunction|"
    uninfl = Kanones.UninflectedParser("uninflected")
    stemrow = Kanones.readstemrow(uninfl, cex)

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

     
    @test stemrow.form == "καί"
    @test stemrow.stemcategory == "conjunction"
end
