
@testset "Test IO for delimited text" begin
    delimited = "uninflectedstems.n51951|lsj.n51951|καί|conjunction|"
    uninflio = Kanones.UninflectedIO("IO for uninfls")
    stem = Kanones.readstemrow(uninflio, delimited)
    @test stem isa UninflectedStem
    @test cex(stem) == "uninflectedstems.n51951|Uninflected conjunction καί|καί|lsj.n51951|conjunction"

end
#=

@testset "Test data accessors" begin
    delimited = "pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article"
    pronounio = Kanones.PronounIO("IO for pronouns")
    stem = Kanones.readstemrow(pronounio, delimited)
    expectedurn = StemUrn("pronoun.n71882a")
    @test urn(stem) == expectedurn

    dict = Dict("pronoun" => "urn:cite2:kanones:pronoun.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:pronoun.v1:n71882a")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n71882")
    @test stemstring(stem) == "ὁ"
    @test code(stem) == "9010001100"
    @test formurn(stem) == FormUrn("forms.9010001100")
    
end

=#