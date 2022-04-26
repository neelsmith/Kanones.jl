@testset "Test citable trait for UninflectedStem" begin
    cexsrc = "uninflectedstems.uninf2|lsj.n51951|καί|conjunction|"
    uninfl = Kanones.UninflectedIO("uninflected")
    stem = Kanones.readstemrow(uninfl, cexsrc)

    @test label(stem) == "Uninflected conjunction καί"
    @test urn(stem) == StemUrn("uninflectedstems.uninf2")
    @test cex(stem) == "uninflectedstems.uninf2|Uninflected conjunction καί"

    dict = Dict(
       "uninflectedstems" => "urn:cite2:kanones:uninflectedstems.v1:"
       )
    @test urn(stem; registry = dict) == Cite2Urn("urn:cite2:kanones:uninflectedstems.v1:uninf2")
    @test cex(stem; registry = dict) == "urn:cite2:kanones:uninflectedstems.v1:uninf2|Uninflected conjunction καί"

end
