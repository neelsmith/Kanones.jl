@testset "Test parsing a NounForm from SFST output" begin
    sfst = "<u>nounstems.n20600</u><u>lsj.n20600</u>βουλ<noun><feminine><h_hs><div><h_hs><noun>η<feminine><nominative><singular><u>nouninfl.h_hs1</u>"
    infl = split(sfst,"<div>")[2]
    noun = Kanones.nounfromfst(infl)
    expected = NounForm(2, 1, 1)
    @test noun == expected
end

@testset "Test parsing a NounForm from a FormUrn" begin
    frm = FormUrn("morphforms.2010001100")
    @test Kanones.nounform(frm) == NounForm(1,1,1)
end

@testset "Test parsing a FormUrn from a NounForm" begin
    noun = NounForm(1,1,1)
    formU = Kanones.formurn(noun)
    @test formU == FormUrn("morphforms.2010001100")

    @test Kanones.poscode(formU) == 2
    @test Kanones.poslabel(formU) == "noun"

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

    @test Kanones.degreecode(formU) == 0
    @test Kanones.degreelabel(formU) == "none"
    @test Kanones.uninflectedcode(formU) == 0

end


@testset "Test CitableTrait for noun forms" begin
    sfst = "<u>nounstems.n20600</u><u>lsj.n20600</u>βουλ<noun><feminine><h_hs><div><h_hs><noun>η<feminine><nominative><singular><u>nouninfl.h_hs1</u>"
    infl = split(sfst,"<div>")[2]
    noun = Kanones.nounfromfst(infl)
    @test urn(noun) == Cite2Urn("urn:cite2:kanones:morphforms.v1:2010002100")
    @test label(noun) == "feminine nominative singular"
    @test cex(noun) == "urn:cite2:kanones:morphforms.v1:2010002100|feminine nominative singular"
    @test Kanones.formurn(noun) ==  FormUrn("morphforms.2010002100")
end

