@testset "Test CitableTrait functions for lexeme" begin
    lex = GreekLexeme("id1")
    @test_broken lex == "TBA"
end