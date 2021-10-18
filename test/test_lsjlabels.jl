@testset "Test labelling of LSJ lemmata" begin
    f = joinpath(dirname(pwd(), "lsj", "lsj-lemmata.cex")
    dict = lsjdict(f)

    s = "lsj.n23069"
    expected = "lsj.n23069@γυνή"
    @test Kanones.attach_lemma(s, dict) == expected

    lex = LexemeUrn(s)
    @test Kanones.attach_lema(lex, dict) == expected
end