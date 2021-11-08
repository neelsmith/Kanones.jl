@testset "Test parsing a VerbalAdjectiveForm from SFST output" begin
    sfst =  "<verbaladjective>ητεον<neuter><accusative><singular><u>vadjinfl.econtr1</u>"
    vadj = Kanones.verbaladjectivefromfst(sfst)
    expected = VerbalAdjectiveForm(GMPGender(3), GMPCase(4), GMPNumber(1))
    @test vadj == expected
end


@testset "Test parsing a VerbalAdjectiveForm from a FormUrn" begin
    frm = FormUrn("morphforms.6010003400")
    @test Kanones.verbaladjectiveform(frm) == VerbalAdjectiveForm(GMPGender(3), GMPCase(4), GMPNumber(1))
end

@testset "Test parsing a FormUrn from a VerbalAdjectiveForm" begin
    vadj = VerbalAdjectiveForm(GMPGender(3), GMPCase(4), GMPNumber(1))
    formU = Kanones.formurn(vadj)
    @test formU == FormUrn("morphforms.6010003400")

    @test Kanones.poscode(formU) == 6
    @test Kanones.poslabel(formU) == "verbal-adjective"

    @test Kanones.gendercode(formU) == 3
    @test Kanones.genderlabel(formU) == "neuter"


    @test Kanones.casecode(formU) == 4
    @test Kanones.caselabel(formU) == "accusative"
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


@testset "Test CitableTrait for verbal adjective forms" begin
    vadj =VerbalAdjectiveForm(GMPGender(3), GMPCase(4), GMPNumber(1))

    @test urn(vadj) == Cite2Urn("urn:cite2:kanones:morphforms.v1:6010003400")
    @test label(vadj) == "neuter accusative singular"
    @test cex(vadj) == "urn:cite2:kanones:morphforms.v1:6010003400|neuter accusative singular"
    
    @test Kanones.formurn(vadj) ==  FormUrn("morphforms.6010003400")
end


@testset "Test parsing a RuleUrn from a VerbalAdjectiveRule" begin
    cexsrc = "vadjinfl.econtr1|ew_contract|ητέον|neuter|nominative|singular|"
    vadjio = Kanones.VerbalAdjectiveIO("verbal adjective")
    rule = Kanones.readrulerow(vadjio, cexsrc)

    @test ruleurn(rule) == RuleUrn("morphforms.6010003100")
end