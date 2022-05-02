@testset "Test identifying analytical type from digital code strings" begin
    
    nounid = "2010001100"
    pronounid = "9010002400"
    adjid = "7030002410"
    advid = "8000000020"

    @test Kanones.poscode(nounid) == Kanones.NOUN
    @test Kanones.poscode(pronounid) == Kanones.PRONOUN
    @test Kanones.poscode(adjid) == Kanones.ADJECTIVE
    @test Kanones.poscode(advid) == Kanones.ADVERB

    finiteid = "3323110000"
    infinid = "4003030000"
    ptcplid = "5013022400"
    vadjid = "6010003400"

    @test Kanones.poscode(finiteid) == Kanones.FINITEVERB
    @test Kanones.poscode(infinid) == Kanones.INFINITIVE
    @test Kanones.poscode(ptcplid) == Kanones.PARTICIPLE
    @test Kanones.poscode(vadjid) == Kanones.VERBALADJECTIVE

    uninflid = "1000000001"
    @test Kanones.poscode(uninflid) == Kanones.UNINFLECTED
end

@testset "Test generating Greek forms from codes" begin
    nounid = "2010001100"
    pronounid = "9010002400"
    adjid = "7030002410"
    advid = "8000000020"

    @test greekForm(nounid) isa GMFNoun
    @test greekForm(pronounid) isa GMFPronoun
    @test greekForm(adjid) isa GMFAdjective
    @test_broken greekForm(advid) isa GMFAdverb


    finiteid = "3323110000"
    infinid = "4003030000"
    ptcplid = "5013022400"
    vadjid = "6010003400"

   
    @test greekForm(finiteid) isa GMFFiniteVerb
    @test greekForm(infinid) isa GMFInfinitive
    @test greekForm(ptcplid) isa GMFParticiple
    @test greekForm(vadjid) isa GMFVerbalAdjective

    uninflid = "1000000001"
    @test greekForm(uninflid) isa GMFUninflected
    

    @test greekForm(FormUrn("forms.$(nounid)")) isa GMFNoun
    @test greekForm(FormUrn("forms.$(pronounid)")) isa GMFPronoun
    @test greekForm(FormUrn("forms.$(adjid)")) isa GMFAdjective
    @test_broken greekForm(FormUrn("forms.$(advid)")) isa GMFAdverb


    @test greekForm(FormUrn("forms.$(finiteid)")) isa GMFFiniteVerb
    @test greekForm(FormUrn("forms.$(infinid)")) isa GMFInfinitive
    @test greekForm(FormUrn("forms.$(ptcplid)")) isa GMFParticiple
    @test greekForm(FormUrn("forms.$(vadjid)")) isa GMFVerbalAdjective



    @test greekForm(FormUrn("forms.$(uninflid)")) isa GMFUninflected
end