@testset "Test constructor and constructor functions" begin
    pronoun = GMFPronoun(gmpGender("feminine"), gmpCase("accusative"), gmpNumber(1))
    pronounurn = urn(pronoun)
    expectedurn = Cite2Urn("urn:cite2:kanones:forms.v1:9010002400")
    @test pronounurn == expectedurn
    @test pronoun == gmfPronoun(pronounurn)

    abbrurn = formurn(pronoun)
    expectedabbr = FormUrn("forms.9010002400")
    @test abbrurn == expectedabbr
    @test pronoun == gmfPronoun(abbrurn)


    pronouncode = code(pronoun)
    expectedcode = "9010002400"
    @test pronouncode == expectedcode
    @test pronoun == gmfPronoun(pronouncode)
end

@testset "Test property accessors and labelling" begin
    pronoun = GMFPronoun(gmpGender("feminine"), gmpCase("accusative"), gmpNumber(1))  
    @test label(pronoun) == "pronoun: feminine accusative singular"
    @test label(gmpGender(pronoun)) == "feminine"
    @test label(gmpCase(pronoun)) == "accusative"
    @test label(gmpNumber(pronoun)) == "singular"
end