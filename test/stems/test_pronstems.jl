@testset "Test IO for delimited text for pronouns" begin
    delimited = Unicode.normalize("pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article")
    stem = fromcex(delimited, PronounStem)
    @test stem isa PronounStem
    @test Unicode.normalize(cex(stem)) == Unicode.normalize("pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article")
    @test  fromcex(Unicode.normalize(cex(stem)), PronounStem) == stem

end


@testset "Test data accessors pronouns" begin
    delimited = Unicode.normalize("pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article")
    
    stem = fromcex(delimited, PronounStem)
    expectedurn = StemUrn("pronoun.n71882a")
    @test urn(stem) == expectedurn

    dict = Dict("pronoun" => "urn:cite2:kanones:pronoun.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:pronoun.v1:n71882a")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n71882")
    @test stemstring(stem) == Unicode.normalize("ὁ")
    @test code(stem) == "9010001100"
    @test Kanones.formurn(stem) == FormUrn("forms.9010001100")
    
end
