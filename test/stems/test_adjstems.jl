@testset "Test IO for delimited text" begin
    delimited = "adjstems.n52332|lsj.n52332|κακ|os_h_on_pos|inflectionaccented|"
    adjio = Kanones.AdjectiveIO("IO for adjs")
    stem = Kanones.readstemrow(adjio, delimited)
    @test stem isa AdjectiveStem
    @test cex(stem) == "adjstems.n52332|Adjective stem κακ- (type os_h_on_pos)|κακ|lsj.n52332|os_h_on_pos|inflectionaccented"
end


@testset "Test data accessors" begin
     delimited = "adjstems.n52332|lsj.n52332|κακ|os_h_on_pos|inflectionaccented|"
    adjio = Kanones.AdjectiveIO("IO for adjs")
    stem = Kanones.readstemrow(adjio, delimited)

    @test urn(stem) == StemUrn("adjstems.n52332")
    @test lexeme(stem) == LexemeUrn("lsj.n52332")
    @test stemstring(stem) == "κακ"
    
end