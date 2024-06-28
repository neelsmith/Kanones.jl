@testset "Test constructor and constructor functions" begin
    noun = GMFNoun(gmpGender("feminine"), gmpCase("accusative"), gmpNumber(1))
    nounurn = urn(noun)
    expectedurn = Cite2Urn("urn:cite2:kanones:forms.v1:2010002400")
    @test nounurn == expectedurn
    @test noun == gmfNoun(nounurn)

    abbrurn = Kanones.formurn(noun)
    expectedabbr = FormUrn("forms.2010002400")
    @test abbrurn == expectedabbr
    @test noun == gmfNoun(abbrurn)


    nouncode = code(noun)
    expectedcode = "2010002400"
    @test nouncode == expectedcode
    @test noun == gmfNoun(nouncode)
end


@testset "Test property accessors and labelling" begin
    noun = GMFNoun(gmpGender("feminine"), gmpCase("accusative"), gmpNumber(1))  
    @test label(noun) == "noun: feminine accusative singular"
    @test label(gmpGender(noun)) == "feminine"
    @test label(gmpCase(noun)) == "accusative"
    @test label(gmpNumber(noun)) == "singular"
end


@testset "Test CITE interface on nouns" begin
    noun = GMFNoun(gmpGender("feminine"), gmpCase("accusative"), gmpNumber(1))  

    @test citable(noun)
    @test label(noun) == "noun: feminine accusative singular"
    @test urn(noun) == Cite2Urn("urn:cite2:kanones:forms.v1:2010002400")

end