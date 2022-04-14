@testset ExtendedTestSet "Test labelling of LSJ lemmata" begin
    f = joinpath(dirname(pwd()), "lsj", "lsj-lemmata.cex")
    dict = Kanones.lsjdict(f)

    s = "lsj.n23069"
    expected = LexemeUrn("lsj.n23069@γυνή")
    @test Kanones.attach_lemma(s, dict) == expected

    lex = LexemeUrn(s)
    @test Kanones.attach_lemma(lex, dict) == expected
end