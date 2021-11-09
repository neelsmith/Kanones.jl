@testset "Test parsing a GMFFiniteVerb from SFST output" begin
    sfst = "<third><singular><present><indicative><active>"
    verb = Kanones.verbfromfst(sfst)
    expected = GMFFiniteVerb(GMPPerson(3), GMPNumber(1), GMPTense(1), GMPMood(1), GMPVoice(1))
    @test verb == expected
end

@testset "Test parsing a GMFFiniteVerb from a FormUrn" begin
    frm = FormUrn("morphforms.331111000")
    @test Kanones.gmfFiniteVerb(frm) == GMFFiniteVerb(GMPPerson(3),  GMPNumber(1),  GMPTense(1), GMPMood(1),  GMPVoice(1))
end

@testset "Test parsing a FormUrn from a GMFFiniteVerb" begin
    verb = GMFFiniteVerb(GMPPerson(3),  GMPNumber(1),  GMPTense(1), GMPMood(1),  GMPVoice(1))
    formU = Kanones.formurn(verb)
    @test formU == FormUrn("morphforms.3311110000")



    @test Kanones.poscode(formU) == 3
    @test Kanones.poslabel(formU) == "verb-finite"

    @test Kanones.gendercode(formU) == 0
    @test Kanones.genderlabel(formU) == "none"


    @test Kanones.casecode(formU) == 0
    @test Kanones.caselabel(formU) == "none"
    @test Kanones.numbercode(formU) == 1
    @test Kanones.numberlabel(formU) == "singular"


    @test Kanones.personcode(formU) == 3
    @test Kanones.personlabel(formU) == "third"
    
    @test Kanones.tensecode(formU) == 1
    @test Kanones.tenselabel(formU) == "present"
    @test Kanones.moodcode(formU) == 1
    @test Kanones.moodlabel(formU) == "indicative"
    @test Kanones.voicecode(formU) == 1
    @test Kanones.voicelabel(formU) == "active"

    @test Kanones.degreecode(formU) == 0
    @test Kanones.degreelabel(formU) == "none"
    @test Kanones.uninflectedcode(formU) == 0

end


@testset "Test CitableTrait for finite verb forms" begin
    verb = GMFFiniteVerb(GMPPerson(3),  GMPNumber(1),  GMPTense(1), GMPMood(1),  GMPVoice(1))
    @test urn(verb) == Cite2Urn("urn:cite2:kanones:morphforms.v1:3311110000")
    @test label(verb) ==  "present indicative active third singular"
    @test cex(verb) == "urn:cite2:kanones:morphforms.v1:3311110000|present indicative active third singular"
    @test Kanones.formurn(verb) ==  FormUrn("morphforms.3311110000")
    
end

