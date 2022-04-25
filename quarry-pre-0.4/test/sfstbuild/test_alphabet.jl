@testset ExtendedTestSet "Test composition of alphabet.fst" begin
    repo = dirname(pwd())
    infl = joinpath(repo, "datasets", "core-infl")
    vocab = joinpath(repo, "datasets", "core-vocab")
    kd = Kanones.Dataset([infl, vocab])
    @test typeof(kd.orthography) == LiteraryGreekOrthography

    d = tempdir()
    parserdir = joinpath(d, "testfst")
    if isdir(parserdir)
        rm(parserdir, recursive = true)
    end
    mkdir(parserdir)
    Kanones.FstBuilder.installalphabet(kd, parserdir)
    alphafile = joinpath(parserdir, "symbols", "alphabet.fst")
    @test isfile(alphafile)
    
    alphastring = String(read(alphafile))
    @test contains(alphastring, "#augmentinitial# = ἐ")
    @test contains(alphastring, "#augmentmedial# = ε")
    @test contains(alphastring, "#vowel# = αεηιουω'ἀἐἠἰὀὐὠἁἑἡἱὁὑὡϊϋᾳῃῳᾁᾑᾡᾀᾐᾠ")
    @test contains(alphastring, "#consonant# = βγδζθκλμνξπρστφχψς") 
end