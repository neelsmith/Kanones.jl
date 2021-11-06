@testset "Test parsing an InfinitiveForm from SFST output" begin
    infl = "<present><active>"
    infinitive = Kanones.infinitivefromfst(infl)
    expected = InfinitiveForm(1, 1)
    @test infinitive == expected
end

@testset "Test parsing an InfinitiveForm from a FormUrn" begin
    frm = FormUrn("morphforms.400101000")
    @test Kanones.infinitiveform(frm) == InfinitiveForm(1,1)
end

@testset "Test parsing a FormUrn from an InfinitiveForm" begin
    infinitive = InfinitiveForm(1,1)
    formU = Kanones.formurn(infinitive)
    @test formU == FormUrn("morphforms.4001010000")

    @test Kanones.poscode(formU) == 4
    @test Kanones.poslabel(formU) == "infinitive"

    @test Kanones.tensecode(formU) == 1
    @test Kanones.tenselabel(formU) == "present"
    @test Kanones.voicecode(formU) == 1
    @test Kanones.voicelabel(formU) == "active"

    @test Kanones.casecode(formU) == 0
    @test Kanones.caselabel(formU) == "none"
    @test Kanones.numbercode(formU) == 0
    @test Kanones.numberlabel(formU) == "none"


    @test Kanones.personcode(formU) == 0
    @test Kanones.personlabel(formU) == "none"
    
    @test Kanones.moodcode(formU) == 0
    @test Kanones.moodlabel(formU) == "none"

    @test Kanones.degreecode(formU) == 0
    @test Kanones.degreelabel(formU) == "none"
    @test Kanones.uninflectedcode(formU) == 0

end

@testset "Test CitableTrait for infinitive forms" begin
    infinitive = InfinitiveForm(1,1)
    @test urn(infinitive) == Cite2Urn("urn:cite2:kanones:morphforms.v1:4001010000")
    @test label(infinitive) == "present active infinitive"
    @test cex(infinitive) == "urn:cite2:kanones:morphforms.v1:4001010000|present active infinitive"
    
    @test Kanones.formurn(infinitive) ==  FormUrn("morphforms.4001010000")
end

@testset "Test parsing a RuleUrn from an InfinitiveRule" begin
    cexsrc = "infinfl.wreg1|w_regular|ειν|present|active"
    infinparser = Kanones.InfinitiveIO("infinitives")
    rule = Kanones.readrulerow(infinparser, cexsrc)

    @test ruleurn(rule) == RuleUrn("morphforms.4001010000")
end