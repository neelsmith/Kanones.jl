@testset "Test citable trait for NounStem" begin
    cexsrc = "nounstems.n22502|lexent.n22502|γνωμ|feminine|h_hs|recessive|"
    nounio = Kanones.NounIO("nouns")
    stem =  Kanones.readstemrow(nounio, cexsrc)

    @test label(stem) == "Noun stem γνωμ- (feminine)"
    @test urn(stem) == StemUrn("nounstems.n22502")
    @test cex(stem) == "Noun stem γνωμ- (feminine)|nounstems.n22502"

    dict = Dict(
       "nounstems" => "urn:cite2:kanones:nounstems.v1:"
       )
    @test urn(stem; registry = dict) == Cite2Urn("urn:cite2:kanones:nounstems.v1:n22502")
    @test cex(stem; registry = dict) == "Noun stem γνωμ- (feminine)|urn:cite2:kanones:nounstems.v1:n22502"

end