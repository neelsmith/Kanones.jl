@testset "Test parsing a GMFPronoun from SFST output" begin
    sfst = "<masculine><genitive><singular>"
    pronoun = Kanones.pronounfromfst(sfst)
    expected = GMFPronoun(GMPGender(1), GMPCase(2), GMPNumber(1))
    @test pronoun == expected
end


@testset "Test parsing a GMFPronoun from a FormUrn" begin
    frm = FormUrn("morphforms.9010001200")
    @test Kanones.gmfPronoun(frm) == GMFPronoun(GMPGender(1), GMPCase(2), GMPNumber(1))
end


@testset "Test parsing a FormUrn from a GMFPronoun" begin
    pronoun = GMFPronoun(GMPGender(1), GMPCase(2), GMPNumber(1))
    formU = Kanones.formurn(pronoun)
    @test formU == FormUrn("morphforms.9010001200")

    @test Kanones.poscode(formU) == 9
    @test Kanones.poslabel(formU) == "pronoun"

    @test Kanones.gendercode(formU) == 1
    @test Kanones.genderlabel(formU) == "masculine"


    @test Kanones.casecode(formU) == 2
    @test Kanones.caselabel(formU) == "genitive"
    @test Kanones.numbercode(formU) == 1
    @test Kanones.numberlabel(formU) == "singular"


    @test Kanones.personcode(formU) == 0
    @test Kanones.personlabel(formU) == "none"
    
    @test Kanones.tensecode(formU) == 0
    @test Kanones.tenselabel(formU) == "none"
    @test Kanones.moodcode(formU) == 0
    @test Kanones.moodlabel(formU) == "none"
    @test Kanones.voicecode(formU) == 0
    @test Kanones.voicelabel(formU) == "none"

    @test Kanones.degreecode(formU) == 0
    @test Kanones.degreelabel(formU) == "none"
    @test Kanones.uninflectedcode(formU) == 0

end



@testset "Test CitableTrait for pronoun forms" begin
    pronoun = GMFPronoun(GMPGender(1), GMPCase(2), GMPNumber(1))
    
    @test urn(pronoun) == Cite2Urn("urn:cite2:kanones:morphforms.v1:9010001200")
    @test label(pronoun) == "masculine genitive singular"
    @test cex(pronoun) == "urn:cite2:kanones:morphforms.v1:9010001200|masculine genitive singular"
    @test Kanones.formurn(pronoun) ==  FormUrn("morphforms.9010001200")
end
