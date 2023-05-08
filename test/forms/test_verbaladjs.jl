
@testset "Test constructor and constructor functions" begin
    vadj = GMFVerbalAdjective(gmpGender("neuter"), gmpCase("accusative"), gmpNumber(1))
    vadjurn = urn(vadj)
    expectedurn = Cite2Urn("urn:cite2:kanones:forms.v1:6010003400")
    @test vadjurn == expectedurn
    @test vadj == gmfVerbalAdjective(vadjurn)

    abbrurn = Kanones.formurn(vadj)
    expectedabbr = FormUrn("forms.6010003400")
    @test abbrurn == expectedabbr
    @test vadj == gmfVerbalAdjective(vadjurn)


    vadjcode = code(vadj)
    expectedcode = "6010003400"
    @test vadjcode == expectedcode
    @test vadj == gmfVerbalAdjective(vadjcode)
end


@testset "Test property accessors and labelling" begin
    vadj = GMFVerbalAdjective(gmpGender("neuter"), gmpCase("accusative"), gmpNumber(1)) 
    @test label(vadj) == "verbal adjective: neuter accusative singular"
    @test label(gmpGender(vadj)) == "neuter"
    @test label(gmpCase(vadj)) == "accusative"
    @test label(gmpNumber(vadj)) == "singular"
end
