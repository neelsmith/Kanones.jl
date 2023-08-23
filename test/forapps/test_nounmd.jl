@testset "Test forming markdown of lexicon entry for noun" begin
    repo = pwd() |> dirname
    kd = Kanones.coredata(repo; atticonly =  true)
    lexu = LexemeUrn("lsj.n20600")
    md = lexicon_noun_md(lexu, kd)
    @test md == "βουλή, βουλῆς, *f.*"
end