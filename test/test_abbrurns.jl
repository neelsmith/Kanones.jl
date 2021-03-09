
@testset "Do a test" begin
    au = Kanones.FstBuilder.LexemeUrn("lexicon.lex123")
    fst = Kanones.FstBuilder.fstsafe(au)
    @test fst == "<u>lexicon\\.lex123</u>"
end