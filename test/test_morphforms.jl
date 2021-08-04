
@testset "Test construction of uninflected form from URN" begin
    u = Cite2Urn("urn:cite2:kanones:morphforms.v1:1000000001")
    uform = Kanones.uninflectedform(u)
    @test isa(uform, UninflectedForm)
    @test uform.poslabel == "conjunction"
end

@testset "Test construction of noun form from URN" begin
    u = Cite2Urn("urn:cite2:kanones:morphforms.v1:2030003500")
    noun = Kanones.nounform(u)
    @test isa(noun, NounForm)
    @test noun.genderlabel == "neuter"
    @test noun.caselabel == "vocative"
    @test noun.numberlabel == "plural"
end

@testset "Test construction of finite verb form from URN" begin
    u = Cite2Urn("urn:cite2:kanones:morphforms.v1:3313110000")
    vb = Kanones.finiteverbform(u)
    @test isa(vb, FiniteVerbForm)
    @test vb.personlabel == "third"
    @test vb.numberlabel == "singular"
    @test vb.tenselabel == "future"
    @test vb.moodlabel == "indicative"
    @test vb.voicelabel == "active"
end