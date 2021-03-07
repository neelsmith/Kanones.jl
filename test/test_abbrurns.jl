
@testset "Do a test" begin
    au = AbbreviatedUrn("lexicon.lex123")
    fst = Kanones.fstsafe(au)
    @test fst == "<u>lexicon\\.lex123</u>"
end