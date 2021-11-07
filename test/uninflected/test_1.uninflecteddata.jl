
@testset "Read rules for uninflected tokens from delimited text" begin
    cexsrc = "uninflectedrules.indeclinable2|conjunction"
    uninfl = Kanones.UninflectedIO("uninflected")
    rule = Kanones.readrulerow(uninfl, cexsrc)
    @test rule.infltype == "conjunction"
    expectedrule = RuleUrn("uninflectedrules.indeclinable2")
    @test rule.ruleid.collection == "uninflectedrules"
    @test rule.ruleid.objectid == "indeclinable2"
end



@testset "Read stems for uninflected tokens from delimited text" begin
    cexsrc = "uninflectedstems.uninf2|lsj.n51951|καί|conjunction|"
    uninfl = Kanones.UninflectedIO("uninflected")
    stem = Kanones.readstemrow(uninfl, cexsrc)

    actualstemid = stem.stemid
    @test isa(actualstemid, StemUrn)
    expectedstemid = StemUrn("uninflectedstems.uninf2")
    @test expectedstemid.collection == actualstemid.collection
    @test expectedstemid.objectid == actualstemid.objectid

    actuallexid = stem.lexid
    @test isa(actuallexid, LexemeUrn)
    expectedlexid = LexemeUrn("lsj.n51951")
    @test expectedlexid.collection == actuallexid.collection
    @test expectedlexid.objectid == actuallexid.objectid

     
    @test stem.form == "καί"
    @test stem.stemcategory == "conjunction"
end
