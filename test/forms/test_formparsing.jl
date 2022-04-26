@testset "Test identifying analytical type from digital code strings" begin
    adjid = "7030002410"
    @test Kanones.poscode(adjid) == Kanones.ADJECTIVE
    nounid = "2010001100"
    @test Kanones.poscode(nounid) == Kanones.NOUN
end

@testset "Test generating Greek forms from codes" begin
    adjid = "7030002410"
    @test greekForm(adjid) isa GMFAdjective
    @test_broken greekForm(adjid) isa GMFAdverb
    @test_broken greekForm(adjid) isa GMFFiniteVerb
    @test_broken greekForm(adjid) isa GMFInfinitive
    nounid = "2010001100"
    @test greekForm(nounid) isa GMFNoun
    @test_broken greekForm(adjid) isa GMFParticiple
    @test_broken greekForm(adjid) isa GMFPronoun
    @test_broken greekForm(adjid) isa GMFUninflected
    @test_broken greekForm(adjid) isa GMFVerbalAdjective

    u = FormUrn("forms.$(adjid)")
    @test greekForm(u) isa GMFAdjective
    @test greekForm(FormUrn("forms.$(nounid)")) isa GMFNoun
end