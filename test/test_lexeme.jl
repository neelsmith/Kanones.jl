@testset ExtendedTestSet "Test CitableTrait functions for lexeme" begin
    glex = GreekLexeme(LexemeUrn("lsj.n102429"))
    dict = Dict(
        "lsj" => "urn:cite2:kanones:lsj.v1:"
    )
    repo = dirname(pwd())
    lsjfile = joinpath(repo, "lsj", "lsj-lemmata.cex")
    lsj = Kanones.lsjdict(lsjfile)

    @test label(glex) == "Lexeme lsj.n102429"
    @test label(glex; registry = dict) ==  "Lexeme urn:cite2:kanones:lsj.v1:n102429"
    @test label(glex; lexicon = lsj) == "Lexeme lsj.n102429@ταραξιππόστρατος"
    @test label(glex; lexicon = lsj, registry = dict) == "Lexeme urn:cite2:kanones:lsj.v1:lsj.n102429@ταραξιππόστρατος"

    @test urn(glex) == LexemeUrn("lsj.n102429")
    @test urn(glex; registry = dict) == Cite2Urn("urn:cite2:kanones:lsj.v1:n102429")
    @test urn(glex; lexicon = lsj) == LexemeUrn("lsj.n102429@ταραξιππόστρατος")
    urn(glex; registry = dict, lexicon = lsj) == Cite2Urn("urn:cite2:kanones:lsj.v1:n102429@ταραξιππόστρατος")

    @test cex(glex) == "lsj.n102429|Lexeme lsj.n102429"
    @test cex(glex; registry = dict) == "urn:cite2:kanones:lsj.v1:n102429|Lexeme urn:cite2:kanones:lsj.v1:n102429"
    @test cex(glex; lexicon = lsj) == "lsj.n102429|Lexeme lsj.n102429@ταραξιππόστρατος"
    @test  cex(glex; lexicon = lsj, registry = dict)  == "urn:cite2:kanones:lsj.v1:n102429|Lexeme urn:cite2:kanones:lsj.v1:lsj.n102429@ταραξιππόστρατος"

end