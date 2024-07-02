@testset "Test IO for delimited text for noun stems" begin
    delimited = "nounstems.n8909|lsj.n8909|ἀνθρωπ|masculine|os_ou|recessive|"
    stem = fromcex(delimited, NounStem)
    @test stem isa NounStem
    @test Unicode.normalize(cex(stem)) == Unicode.normalize("nounstems.n8909|lsj.n8909|ἀνθρωπ|masculine|os_ou|recessive")

    @test fromcex(Unicode.normalize(cex(stem)), NounStem) == stem
end

@testset "Test data accessors for nouns" begin
    delimited = "nounstems.n8909|lsj.n8909|ἀνθρωπ|masculine|os_ou|recessive"
    stem = fromcex(delimited, NounStem)

    expectedurn = StemUrn("nounstems.n8909")
    @test urn(stem) == expectedurn

    dict = Dict("nounstems" => "urn:cite2:kanones:nounstems.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:nounstems.v1:n8909")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n8909")
    @test stemstring(stem) == Unicode.normalize("ἀνθρωπ")
    
end