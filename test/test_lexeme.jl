@testset "Test CitableTrait functions for lexeme" begin
    lex = Lexeme("id1")
    @test_broken lex == "TBA"
end