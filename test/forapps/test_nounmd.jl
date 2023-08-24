@testset "Test forming markdown of lexicon entry for noun" begin
    repo = pwd() |> dirname
    kd = Kanones.coredata(repo; atticonly =  true)
    lexu = LexemeUrn("lsj.n20600")
    md = lexicon_noun_md(lexu, kd)
    @test md == "βουλή, βουλῆς, *f.*"

    irreg = LexemeUrn("lsj.n8665")
    stemdata = filter(stemsarray(kd)) do stem
        stem.lexid == irreg
    end
    expected_gender = gmpGender("masculine")
    for stem in stemdata
        @test Kanones.gender(stem) == expected_gender
    end
    
    
    expected_entry = "ἀνήρ, ἀνδρός, *m.*"
    @test lexicon_noun_md(irreg, kd) == expected_entry
end