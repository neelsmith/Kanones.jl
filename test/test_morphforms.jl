
@testset "Test construction of uninflected form from a Cite2Urn" begin
    u = Cite2Urn("urn:cite2:kanones:morphforms.v1:1000000001")
    uform = Kanones.uninflectedform(u)
    @test isa(uform, UninflectedForm)
    @test uform.pos ==  GMPUninflectedType(1)
end

@testset "Test construction of noun form from a Cite2Urn" begin
    u = Cite2Urn("urn:cite2:kanones:morphforms.v1:2030003500")
    noun = Kanones.nounform(u)
    @test isa(noun, NounForm)
    @test noun.ngender == GMPGender(3)
    @test noun.ncase == GMPCase(5)
    @test noun.nnumber == GMPNumber(3)
end

@testset "Test construction of finite verb form from a Cite2Urn" begin
    u = Cite2Urn("urn:cite2:kanones:morphforms.v1:3313110000")
    vb = Kanones.finiteverbform(u)
    @test isa(vb, GMFFiniteVerb)
    #@test vb.personlabel == "third"
    #@test vb.numberlabel == "singular"
    #@test vb.tenselabel == "future"
    #@test vb.moodlabel == "indicative"
    #@test vb.voicelabel == "active"
end