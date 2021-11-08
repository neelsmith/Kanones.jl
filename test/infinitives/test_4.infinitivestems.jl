
@testset "Test citable trait for IrreglarInfinitiveStem" begin
    cexsrc = "irreginf.irreginfln26447a|lsj.n26447|διδόναι|present|active|irregularinfinitive"
    irreginfio = Kanones.IrregularInfinitiveIO("irregular infinitives")
    stem = Kanones.readstemrow(irreginfio, cexsrc)

    @test label(stem) == "Irregular infinitive form διδόναι (present active)"
    @test urn(stem) == StemUrn("irreginf.irreginfln26447a")
    @test cex(stem) == "irreginf.irreginfln26447a|Irregular infinitive form διδόναι (present active)"

    dict = Dict(
        "irreginf" => "urn:cite2:kanones:irreginf.v1:"
    )

   @test  urn(stem; registry = dict) == Cite2Urn("urn:cite2:kanones:irreginf.v1:irreginfln26447a")
   @test  cex(stem; registry = dict) == "urn:cite2:kanones:irreginf.v1:irreginfln26447a|Irregular infinitive form διδόναι (present active)"
    
    
end