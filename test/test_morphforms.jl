@testset ExtendedTestSet begin
@testset  "Test construction of uninflected form from a Cite2Urn" begin
    u = Cite2Urn("urn:cite2:kanones:morphforms.v1:1000000001")
    uform = Kanones.gmfUninflected(u)
    @test isa(uform, GMFUninflected)
    @test uform.pos ==  GMPUninflectedType(1)
end

@testset  "Test construction of noun form from a Cite2Urn" begin
    u = Cite2Urn("urn:cite2:kanones:morphforms.v1:2030003500")
    noun = Kanones.gmfNoun(u)
    @test isa(noun, GMFNoun)
    @test noun.ngender == GMPGender(3)
    @test noun.ncase == GMPCase(5)
    @test noun.nnumber == GMPNumber(3)
end

@testset  "Test construction of finite verb form from a Cite2Urn" begin
    u = Cite2Urn("urn:cite2:kanones:morphforms.v1:3313110000")
    vb = Kanones.gmfFiniteVerb(u)
    @test isa(vb, GMFFiniteVerb)
    #@test vb.personlabel == "third"
    #@test vb.numberlabel == "singular"
    #@test vb.tenselabel == "future"
    #@test vb.moodlabel == "indicative"
    #@test vb.voicelabel == "active"
end
end