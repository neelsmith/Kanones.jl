@testset "Test constructor and constructor functions" begin
    verb = GMFFiniteVerb(
        gmpPerson(3), gmpNumber(2),
        gmpTense("aorist"), gmpMood("indicative"),
        gmpVoice("active")        
    )

    verburn = urn(verb)
    expectedurn = Cite2Urn("urn:cite2:kanones:forms.v1:3323110000")
    @test verburn == expectedurn
    @test gmfFiniteVerb(verburn) == verb

    abbrurn = formurn(verb)
    expectedabbr = FormUrn("forms.3323110000")
    @test abbrurn == expectedabbr
    @test gmfFiniteVerb(abbrurn) == verb

    # test roundtripping code

end



@testset "Test property accessors and labelling" begin
    ## TBA
end