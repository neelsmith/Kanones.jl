@testset "Test parsing an GMFUninflected from SFST output" begin

    sfstvalue = "conjunction"
    uninflected = Kanones.uninflectedfromfst(sfstvalue)
    expected = GMFUninflected(GMPUninflectedType(1))

    @test uninflected == expected
end

@testset "Test parsing a GMFUninflected from a FormUrn" begin
    frm = FormUrn("$(COLLECTION_ID).1000000001")
    @test Kanones.gmfUninflected(frm) == GMFUninflected(GMPUninflectedType(1))

end

@testset "Test parsing a FormUrn from a GMFUninflected" begin
    uninflected = GMFUninflected(GMPUninflectedType(1))

    formU = Kanones.formurn(uninflected)
    @test formU == FormUrn("$(COLLECTION_ID).1000000001")

    @test Kanones.poscode(formU) == 1
    @test Kanones.poslabel(formU) == "uninflected"

    @test Kanones.gendercode(formU) == 0
    @test Kanones.genderlabel(formU) == "none"


    @test Kanones.casecode(formU) == 0
    @test Kanones.caselabel(formU) == "none"
    @test Kanones.numbercode(formU) == 0
    @test Kanones.numberlabel(formU) == "none"


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
    @test Kanones.uninflectedcode(formU) == 1
    Kanones.uninflectedlabel(formU) == "conjunction"

end


@testset "Test CitableTrait for uninflected forms" begin
    uninflected = GMFUninflected(GMPUninflectedType(1))


    @test urn(uninflected) == Cite2Urn("urn:cite2:kanones:morphforms.v1:1000000001")
    @test label(uninflected) == "conjunction"
    @test cex(uninflected) == "urn:cite2:kanones:morphforms.v1:1000000001|conjunction"
    @test Kanones.formurn(uninflected) ==  FormUrn("$(COLLECTION_ID).1000000001")
end

