@testset "Test constructor and constructor functions" begin
    # True constructor from morphological properties
    uninfl = GMFUninflected(gmpUninflectedType("preposition"))

    uninflurn = urn(uninfl)
    expectedurn = Cite2Urn("urn:cite2:kanones:forms.v1:1000000002")
    @test uninflurn == expectedurn
    @test uninfl == gmfUninflected(uninflurn)
    

    abbrurn = Kanones.formurn(uninfl)
    expectedabbr = FormUrn("forms.1000000002")
    @test abbrurn == expectedabbr
    @test uninfl == gmfUninflected(abbrurn)

    uninflcode = code(uninfl)
    expectedcode = "1000000002"
    @test uninflcode == expectedcode
    @test uninfl == gmfUninflected(uninflcode)
end


@testset "Test property accessors and labelling" begin
    uninfl = GMFUninflected(gmpUninflectedType("preposition"))
    
    @test gmpUninflectedType(uninfl) == gmpUninflectedType("preposition")

    @test label(uninfl) == "uninflected form: preposition"
end
