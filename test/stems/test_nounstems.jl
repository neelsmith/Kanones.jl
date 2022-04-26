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

    @test urn(stem) == StemUrn("nounstems.n8909")
    @test lexeme(stem) == LexemeUrn("lsj.n8909")
    @test stemstring(stem) == "ἀνθρωπ"
    
end