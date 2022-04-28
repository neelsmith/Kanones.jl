@testset "Test IO for delimited text" begin
    delimited = "nounstems.n8909|lsj.n8909|ἀνθρωπ|masculine|os_ou|recessive|"
    nounio = Kanones.NounIO("IO for nouns")
    stem = Kanones.readstemrow(nounio, delimited)
    @test stem isa NounStem
    @test cex(stem) == "nounstems.n8909|Noun stem ἀνθρωπ- (masculine)|ἀνθρωπ|lsj.n8909|os_ou|masculine|recessive"
end

@testset "Test data accessors" begin
    delimited = "nounstems.n8909|lsj.n8909|ἀνθρωπ|masculine|os_ou|recessive|"
    nounio = Kanones.NounIO("IO for nouns")
    stem = Kanones.readstemrow(nounio, delimited)

    expectedurn = StemUrn("nounstems.n8909")
    @test urn(stem) == expectedurn

    dict = Dict("nounstems" => "urn:cite2:kanones:nounstems.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:nounstems.v1:n8909")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n8909")
    @test stemstring(stem) == "ἀνθρωπ"
    
end