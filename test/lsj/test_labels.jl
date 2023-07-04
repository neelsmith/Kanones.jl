@testset "Test labelling lexemes identified by URN" begin
    lex = LexemeUrn("lsj.n94711")
    expected = "lsj.n94711@σκέπτομαι"


    @test Kanones.lemmalabel(lex) == expected
    d  = Kanones.lemmatadict()
    Kanones.lemmalabel(lex, dict = d) == expected

    
end