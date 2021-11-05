@testset "Test citable trait for NounStem" begin
    cexsrc = "nounstems.n22502|lexent.n22502|γνωμ|feminine|h_hs|recessive|"
    nounio = Kanones.NounIO("nouns")
    stem =  Kanones.readstemrow(nounio, cexsrc)

    @test label(stem) == "Noun stem γνωμ- (feminine)"
    @test urn(stem) == StemUrn("nounstems.n22502")
    @test cex(stem) == "nounstems.n22502|Noun stem γνωμ- (feminine)"

    dict = Dict(
       "nounstems" => "urn:cite2:kanones:nounstems.v1:"
       )
    @test urn(stem; registry = dict) == Cite2Urn("urn:cite2:kanones:nounstems.v1:n22502")
    @test cex(stem; registry = dict) == "urn:cite2:kanones:nounstems.v1:n22502|Noun stem γνωμ- (feminine)"
end

@testset "Test citable trait for IrreglarNounStem" begin
    cexsrc = "irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun"
    irregnounio = Kanones.IrregularNounIO("irregular nouns")
    stem = Kanones.readstemrow(irregnounio, cexsrc)
    @test label(stem) == "Irregular noun form γυνή (feminine nominative singular)"
    @test urn(stem) == StemUrn("irregnoun.irregn23069a")
    @test cex(stem) == "irregnoun.irregn23069a|Irregular noun form γυνή (feminine nominative singular)"
    dict = Dict(
        "irregnoun" => "urn:cite2:kanones:irregnoun.v1:"
    )
   @test  urn(stem; registry = dict) == Cite2Urn("urn:cite2:kanones:irregnoun.v1:irregn23069a")
   @test  cex(stem; registry = dict) == "urn:cite2:kanones:irregnoun.v1:irregn23069a|Irregular noun form γυνή (feminine nominative singular)"
    # ??
    
end