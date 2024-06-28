
@testset "Test IO for delimited text for verb stems" begin
    delimited = "verbstems.n23658|lsj.n23658|δεικ|numi|"
    verbio = Kanones.VerbIO("IO for verbs")
    stem = Kanones.readstemrow(verbio, delimited)
    @test stem isa VerbStem
    @test Unicode.normalize(cex(stem)) == Unicode.normalize("verbstems.n23658|Verb stem δεικ- (lsj.n23658, stem class numi)|δεικ|lsj.n23658|numi")
end

@testset "Test data accessors for verb stems" begin
    delimited = "verbstems.n23658|lsj.n23658|δεικ|numi|"
    verbio = Kanones.VerbIO("IO for verbs")
    stem = Kanones.readstemrow(verbio, delimited)


    expectedurn = StemUrn("verbstems.n23658")
    @test urn(stem) == expectedurn

    dict = Dict("verbstems" => "urn:cite2:kanones:verbstems.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:verbstems.v1:n23658")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexemeurn(stem) == LexemeUrn("lsj.n23658")
    @test stemstring(stem) == Unicode.normalize("δεικ")
    
end

@testset "Test accent errors" begin
    delimited = "verbstems.n1782|lsjx.n1782|ἀεσκ|w_regular|"
    verbio = Kanones.VerbIO("IO for verbs")
    stem = Kanones.readstemrow(verbio, delimited)
end