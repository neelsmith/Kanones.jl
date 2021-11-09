@testset "Test parsing a GMFParticiple from SFST output" begin
    sfst =  "<participle>ομενον<present><middle><masculine><accusative><singular><u>ptcplinfl.wpres4</u>"
#<u>verbstems.n56496</u><u>lsj.n56496</u><stem>κελευ<finiteverb><w_regular><div><w_regular><participle>ομενον<present><middle><masculine><accusative><singular><u>ptcplinfl.wpres4</u>

    ptcpl = Kanones.participlefromfst(sfst)
    expected = GMFParticiple(GMPTense(1), GMPVoice(2), GMPGender(1), GMPCase(4), GMPNumber(1))

    @test ptcpl == expected
end


@testset "Test parsing a GMFParticiple from a FormUrn" begin
    frm = FormUrn("morphforms.5011021400")
    @test Kanones.gmfParticiple(frm) == GMFParticiple(GMPTense(1), GMPVoice(2), GMPGender(1), GMPCase(4), GMPNumber(1))
end


@testset "Test parsing a FormUrn from a GMFParticiple" begin
    ptcpl = GMFParticiple(GMPTense(1), GMPVoice(2), GMPGender(1), GMPCase(4), GMPNumber(1))
    formU = Kanones.formurn(ptcpl)
    @test formU == FormUrn("morphforms.5011021400")

    @test Kanones.poscode(formU) == 5
    @test Kanones.poslabel(formU) == "participle"

    @test Kanones.gendercode(formU) == 1
    @test Kanones.genderlabel(formU) == "masculine"


    @test Kanones.casecode(formU) == 4
    @test Kanones.caselabel(formU) == "accusative"
    @test Kanones.numbercode(formU) == 1
    @test Kanones.numberlabel(formU) == "singular"


    @test Kanones.personcode(formU) == 0
    @test Kanones.personlabel(formU) == "none"
    
    @test Kanones.tensecode(formU) == 1
    @test Kanones.tenselabel(formU) == "present"
    @test Kanones.moodcode(formU) == 0
    @test Kanones.moodlabel(formU) == "none"
    @test Kanones.voicecode(formU) == 2
    @test Kanones.voicelabel(formU) == "middle"

    @test Kanones.degreecode(formU) == 0
    @test Kanones.degreelabel(formU) == "none"
    @test Kanones.uninflectedcode(formU) == 0

end


@testset "Test CitableTrait for participle forms" begin
    ptcpl = GMFParticiple(GMPTense(1), GMPVoice(2), GMPGender(1), GMPCase(4), GMPNumber(1))

    @test urn(ptcpl) == Cite2Urn("urn:cite2:kanones:morphforms.v1:5011021400")
    @test label(ptcpl) == "present middle masculine accusative singular"
    @test cex(ptcpl) == "urn:cite2:kanones:morphforms.v1:5011021400|present middle masculine accusative singular"
    
    @test Kanones.formurn(ptcpl) ==  FormUrn("morphforms.5011021400")
end



@testset "Test parsing a RuleUrn from a ParticipleRule" begin
    cexsrc = "ptcplinfl.wpres11p|w_regular|όμενον|present|middle|neuter|nominative|singular|"
    ptpcplio = Kanones.ParticipleIO("participles")
    rule = Kanones.readrulerow(ptpcplio, cexsrc)

    @test ruleurn(rule) == RuleUrn("morphforms.5011023100")
end