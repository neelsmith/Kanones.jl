
@testset "Test fst encdoing of URNs" begin
    au = Kanones.LexemeUrn("lexicon.lex123")
    fst = Kanones.fstsafe(au)
    @test fst == "<u>lexicon\\.lex123</u>"
end