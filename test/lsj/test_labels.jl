@testset "Test labelling lexemes identified by URN" begin
    lex = LexemeUrn("lsj.n94711")
    lexcite = Cite2Urn("urn:cite2:kanones:lsj.v1:n94711")
    expected = "lsj.n94711@σκέπτομαι"

    @test Kanones.lemmalabel(lex) == expected
    @test Kanones.lemmalabel(lexcite) == expected
    @test Kanones.lemmalabel(string(lex)) == expected
    d  = Kanones.lemmatadict()
    Kanones.lemmalabel(lex, dict = d) == expected
    Kanones.lemmalabel(lexcite, dict = d) == expected
    Kanones.lemmalabel(string(lex), dict = d) == expected


end