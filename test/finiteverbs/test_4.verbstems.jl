@testset "Test citable trait for VerbStem" begin
    cexsrc = "verbstems.n56496|lsj.n56496|κελευ|w_regular|"
    verbio = Kanones.VerbIO("verbs")
    stem = Kanones.readstemrow(verbio, cexsrc)

    @test label(stem) == "Verb stem κελευ- (lsj.n56496, stem class w_regular)"
    @test urn(stem) == StemUrn("verbstems.n56496")
    @test cex(stem) == "verbstems.n56496|Verb stem κελευ- (lsj.n56496, stem class w_regular)"
    dict = Dict(
       "verbstems" => "urn:cite2:kanones:verbstems.v1:"
       )
    @test urn(stem; registry = dict) == Cite2Urn("urn:cite2:kanones:verbstems.v1:n56496")
    @test cex(stem; registry = dict) == "urn:cite2:kanones:verbstems.v1:n56496|Verb stem κελευ- (lsj.n56496, stem class w_regular)"
end

@testset "Test citable trait for IrreglarVerbStem" begin
    cexsrc = "irregverb.n110639a|lsj.n110639|φησί|third|singular|present|indicative|active|irregularverb"
    verbio = Kanones.VerbIO("verbs")
    stem = Kanones.readstemrow(verbio, cexsrc)
    @test_broken label(stem) == "Irregular verb form φησί"
    @test urn(stem) == StemUrn("irregverb.n110639a")
    @test_broken cex(stem) == "irregverb.n110639a|Irregular verb form φησί"
    dict = Dict(
        "irregverb" => "urn:cite2:kanones:irregverb.v1:"
    )
   @test  urn(stem; registry = dict) == Cite2Urn("urn:cite2:kanones:irregverb.v1:n110639a")
   @test_broken  cex(stem; registry = dict) == "urn:cite2:kanones:irregverb.v1:n110639a|Irregular verb form φησί"
    
end