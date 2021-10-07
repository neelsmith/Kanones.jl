@testset "Test tearing apart FormUrns" begin
    frm = FormUrn("morphforms.1000000003")
    @test Kanones.poscode(frm) == 1
    @test Kanones.poslabel(frm) == "uninflected"

    @test Kanones.gendercode(frm) == 0
    @test Kanones.genderlabel(frm) == "none"
    @test Kanones.casecode(frm) == 0
    @test Kanones.caselabel(frm) == "none"
    @test Kanones.numbercode(frm) == 0
    @test Kanones.numberlabel(frm) == "none"
    @test Kanones.personcode(frm) == 0
    @test Kanones.personlabel(frm) == "none"
    @test Kanones.tensecode(frm) == 0
    @test Kanones.tenselabel(frm) == "none"
    @test Kanones.moodcode(frm) == 0
    @test Kanones.moodlabel(frm) == "none"
    @test Kanones.voicecode(frm) == 0
    @test Kanones.voicelabel(frm) == "none"

    @test Kanones.degreecode(frm) == 0
    @test Kanones.degreelabel(frm) == "none"

    @test Kanones.uninflectedcode(frm) == 3
    @test Kanones.uninflectedlabel(frm) == "particle"


end

@testset "Test converting forms to URN values" begin
    gdict = Kanones.genderpairs |> Kanones.labeldict
    cdict = Kanones.casepairs |> Kanones.labeldict
    ndict = Kanones.numberpairs |> Kanones.labeldict
    nounForm = NounForm(gdict["feminine"], cdict["nominative"], ndict["plural"])

    expectedUrn = Cite2Urn("urn:cite2:kanones:morphforms.v1:2030002100")
    @test CitableParserBuilder.urn(nounForm) == expectedUrn
    #abbrurnstr = urn(nounForm) |> abbreviate
    #expectedAbbrUrn = "morphforms.2030002100"
    #@test abbrurnstr == expectedAbbrUrn
end