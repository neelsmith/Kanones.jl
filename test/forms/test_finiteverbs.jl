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
    verbcode = code(verb)
    expectedcode = "3323110000"
    @test verbcode == expectedcode
    @test verb == gmfFiniteVerb(verbcode)

end


@testset "Test property accessors and labelling" begin
    verb = GMFFiniteVerb(
        gmpPerson(3), gmpNumber(3),
        gmpTense("aorist"), gmpMood("indicative"),
        gmpVoice("active")        
    )
    @test label(verb) == "finite verb:  aorist indicative active third plural"
    @test label(gmpPerson(verb)) == "third"
    @test label(gmpNumber(verb)) == "plural"
    @test label(gmpTense(verb)) == "aorist"
    @test label(gmpMood(verb)) == "indicative"
    @test label(gmpVoice(verb)) == "active"
end