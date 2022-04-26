@testset "Test constructor and constructor functions" begin
    # True constructor from morphological properties
    adv = GMFAdverb(gmpDegree("comparative"))

    advurn = urn(adv)
    expectedurn = Cite2Urn("urn:cite2:kanones:forms.v1:8000000020")
    @test advurn == expectedurn
    @test adv == gmfAdverb(advurn)
    

    abbrurn = formurn(adv)
    expectedabbr = FormUrn("forms.8000000020")
    @test abbrurn == expectedabbr
    @test adv == gmfAdverb(abbrurn)

    advcode = code(adv)
    expectedcode = "8000000020"
    @test advcode == expectedcode
    @test adv == gmfAdverb(advcode)
end

#=
@testset "Test property accessors and labelling" begin
    adv = GMFAdverb(gmpDegree("comparative"))
    @test gmpDegree(adv) == gmpDegree(2)

    @test label(adv) == "adverb: comparative degree"
end
=#