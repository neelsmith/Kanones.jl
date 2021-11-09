
@testset "Test parsing an GMFAdjective from SFST output" begin
    sfst =  "<u>adjstems.n52840a</u><u>lsj.n52840</u>καλ<adjective><os_h_on_pos><div><os_h_on_pos><adjective>ος<masculine><nominative><singular><positive><u>adjinfl.oshon_pos1</u>"
    infl = split(sfst,"<div>")[2]
    adj = Kanones.adjectivefromfst(infl)
    expected = GMFAdjective(GMPGender(1), GMPCase(1), GMPNumber(1), GMPDegree(1))
    @test adj == expected
end

@testset "Test parsing an GMFAdjective from a FormUrn" begin
    frm = FormUrn("morphforms.7010001110")
    @test Kanones.gmfAdjective(frm) == GMFAdjective(GMPGender(1), GMPCase(1), GMPNumber(1), GMPDegree(1))
end


@testset "Test parsing a FormUrn from an GMFAdjective" begin
    adj = GMFAdjective(GMPGender(1), GMPCase(1), GMPNumber(1), GMPDegree(1))
    formU = Kanones.formurn(adj)
    @test formU == FormUrn("morphforms.7010001110")

    @test Kanones.poscode(formU) == 7
    @test Kanones.poslabel(formU) == "adjective"

    @test Kanones.gendercode(formU) == 1
    @test Kanones.genderlabel(formU) == "masculine"


    @test Kanones.casecode(formU) == 1
    @test Kanones.caselabel(formU) == "nominative"
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

    @test Kanones.degreecode(formU) == 1
    @test Kanones.degreelabel(formU) == "positive"
    @test Kanones.uninflectedcode(formU) == 0

end


@testset "Test CitableTrait for adjective forms" begin
    adj =GMFAdjective(GMPGender(1), GMPCase(1), GMPNumber(1), GMPDegree(1))
    @test urn(adj) == Cite2Urn("urn:cite2:kanones:morphforms.v1:7010001110")
    @test label(adj) == "masculine nominative singular positive"
    @test cex(adj) == "urn:cite2:kanones:morphforms.v1:7010001110|masculine nominative singular positive"
    @test Kanones.formurn(adj) ==  FormUrn("morphforms.7010001110")
end


@testset "Test parsing a RuleUrn from an AdjectiveRule" begin
    cexsrc = "adjinfl.oshon_pos1|os_h_on_pos|ος|masculine|nominative|singular|positive|"
    adjio = Kanones.AdjectiveIO("r/w adjectives")
    rule = Kanones.readrulerow(adjio, cexsrc)

    @test ruleurn(rule) == RuleUrn("morphforms.7010001110")
end