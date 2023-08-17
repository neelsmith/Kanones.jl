@testset "Test IO for delimited text of adjectives" begin
    delimited = "adjstems.n52332|lsj.n52332|κακ|os_h_on_pos|inflectionaccented|"
    adjio = Kanones.AdjectiveIO("IO for adjs")
    stem = Kanones.readstemrow(adjio, delimited)
    @test stem isa AdjectiveStem
    @test Unicode.normalize(cex(stem)) == Unicode.normalize("adjstems.n52332|Adjective stem κακ- (type os_h_on_pos)|κακ|lsj.n52332|os_h_on_pos|inflectionaccented")
end


@testset "Test data accessors for adjectives" begin
     delimited = "adjstems.n52332|lsj.n52332|κακ|os_h_on_pos|inflectionaccented|"
    adjio = Kanones.AdjectiveIO("IO for adjs")
    stem = Kanones.readstemrow(adjio, delimited)

    expectedurn = StemUrn("adjstems.n52332")
    @test urn(stem) == expectedurn


    dict = Dict("adjstems" => "urn:cite2:kanones:adjstems.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:adjstems.v1:n52332")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n52332")
    @test Unicode.normalize(stemstring(stem)) == Unicode.normalize("κακ")
    
end