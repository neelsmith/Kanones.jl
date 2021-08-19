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