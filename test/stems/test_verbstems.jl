
@testset "Test IO for delimited text for verb stems" begin
    delimited = "verbstems.n23658|lsj.n23658|δεικ|numi|"
    #verbio = Kanones.VerbIO("IO for verbs")
    stem = fromcex(delimited, VerbStem)
    @test stem isa VerbStem
    @test cex(stem) == "verbstems.n23658|lsj.n23658|δεικ|numi|false"

    @test fromcex(cex(stem), VerbStem)  == stem
end

@testset "Test data accessors for verb stems" begin
    delimited = "verbstems.n23658|lsj.n23658|δεικ|numi|"
    stem = fromcex(delimited, VerbStem)


    expectedurn = StemUrn("verbstems.n23658")
    @test urn(stem) == expectedurn

    dict = Dict("verbstems" => "urn:cite2:kanones:verbstems.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:verbstems.v1:n23658")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n23658")
    @test stemstring(stem) == Unicode.normalize("δεικ")
    
end

@testset "Test accent errors" begin
    delimited = "verbstems.n1782|lsjx.n1782|ἀεσκ|w_regular|"
    stem = fromcex(delimited, VerbStem)
end