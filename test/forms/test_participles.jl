@testset "Test constructor and constructor functions" begin
    ptcpl = GMFParticiple( gmpTense("aorist"), gmpVoice("middle"), gmpGender("feminine"), gmpCase("accusative"), gmpNumber(1))

    ptcplurn = urn(ptcpl)
    expectedurn = Cite2Urn("urn:cite2:kanones:forms.v1:5013022400")

    @test ptcplurn == expectedurn
    @test ptcpl == gmfParticiple(ptcplurn)

    abbrurn = Kanones.formurn(ptcpl)
    expectedabbr = FormUrn("forms.5013022400")
    @test abbrurn == expectedabbr
    @test ptcpl == gmfParticiple(abbrurn)


    ptcplcode = code(ptcpl)
    expectedcode = "5013022400"
    @test ptcplcode == expectedcode
    @test ptcpl == gmfParticiple(ptcplcode)
end


@testset "Test property accessors and labelling" begin
    ptcpl = GMFParticiple( gmpTense("aorist"), gmpVoice("middle"), gmpGender("feminine"), gmpCase("accusative"), gmpNumber(1))
  
    @test label(ptcpl) == "participle: aorist middle feminine accusative singular"
    @test label(gmpGender(ptcpl)) == "feminine"
    @test label(gmpCase(ptcpl)) == "accusative"
    @test label(gmpNumber(ptcpl)) == "singular"
    @test label(gmpTense(ptcpl)) == "aorist"
    @test label(gmpVoice(ptcpl)) == "middle"
end