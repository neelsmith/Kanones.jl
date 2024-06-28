@testset "Test constructor and constructor functions" begin
    inf = GMFInfinitive(gmpTense("aorist"), gmpVoice("passive"))
    infurn = urn(inf)
    expectedurn = Cite2Urn("urn:cite2:kanones:forms.v1:4003030000")
    @test infurn == expectedurn
    @test inf == gmfInfinitive(infurn)

    abbrurn = Kanones.formurn(inf)
    expectedabbr = FormUrn("forms.4003030000")
    @test abbrurn == expectedabbr
    @test inf == gmfInfinitive(abbrurn)


    infcode = code(inf)
    expectedcode = "4003030000"
    @test infcode == expectedcode
    @test inf == gmfInfinitive(infcode)
end




@testset "Test property accessors and labelling" begin
    inf = GMFInfinitive(gmpTense("aorist"), gmpVoice("passive"))
    @test label(inf) == "infinitive: aorist passive"

    @test label(gmpTense(inf)) == "aorist"
    @test label(gmpVoice(inf)) == "passive"
   
end


@testset "Test CITE interface on infinitives" begin
    inf = GMFInfinitive(gmpTense("aorist"), gmpVoice("passive"))
    @test citable(inf)
    @test label(inf) == "infinitive: aorist passive"
    @test urn(inf) == Cite2Urn("urn:cite2:kanones:forms.v1:4003030000")
end