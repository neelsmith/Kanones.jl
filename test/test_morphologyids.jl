
@testset "Test uninflected form URNs" begin
    conjunctionurn = Cite2Urn("urn:cite2:kanones:morphforms.v1:1000000001")
    uform = Kanones.uninflectedform(conjunctionurn)
    @test uform.pos == 1
end
    #=
     "urn:cite2:kanones:morphforms.v1:1000000001|uninflected form: conjunction"
 "urn:cite2:kanones:morphforms.v1:1000000002|uninflected form: preposition"
 "urn:cite2:kanones:morphforms.v1:1000000003|uninflected form: particle"
 "urn:cite2:kanones:morphforms.v1:1000000004|uninflected form: adverb"
 "urn:cite2:kanones:morphforms.v1:1000000005|uninflected form: numeral"
 "urn:cite2:kanones:morphforms.v1:1000000006|uninflected form: interjection"
=#

@testset "Test conversion of uninflected form to URN" begin
    uform = UninflectedForm(1)
    u = Kanones.urn(uform)
    @test u == Cite2Urn("urn:cite2:kanones:morphforms.v1:1000000001")
end
