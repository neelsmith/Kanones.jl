@testset "Test citable trait for AdjectiveStem" begin
    cexsrc = "adjstems.n52840a|lsj.n52840|καλ|os_h_on_pos|inflectionaccented|"
    adjectiveio = Kanones.AdjectiveIO("adjectives")
    stem = Kanones.readstemrow(adjectiveio, cexsrc)

    @test label(stem) == "Adjective stem καλ- (type os_h_on_pos)"
    @test urn(stem) == StemUrn("adjstems.n52840a")
    @test cex(stem) == "Adjective stem καλ- (type os_h_on_pos)|adjstems.n52840a"

    dict = Dict(
       "adjstems" => "urn:cite2:kanones:adjstems.v1:"
       )
    @test urn(stem; registry = dict) == Cite2Urn("urn:cite2:kanones:adjstems.v1:n52840a")
    @test cex(stem; registry = dict) == "Adjective stem καλ- (type os_h_on_pos)|urn:cite2:kanones:adjstems.v1:n52840a"

end