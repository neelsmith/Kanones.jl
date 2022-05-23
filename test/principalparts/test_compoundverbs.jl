
@testset "Test parsing delimited text for a compound verb stem" begin
    s = "compounds.n30252|lsj.n30252|ἐν|lsj.n56496|ἐγκελεύω"
    compound = compoundstem(s)
    @test compound isa CompoundVerbStem

    @test lexeme(compound) == LexemeUrn("lsj.n30252")

    @test simplex(compound) == LexemeUrn("lsj.n56496")

    @test prefix(compound) == nfkc("ἐν")
end

@testset "Test constructing stem objects for compound verb" begin
    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset

    s = "compounds.n30252|lsj.n30252|ἐν|lsj.n56496|ἐγκελεύω"
    compound = compoundstem(s)

    compoundstems = Kanones.stems(compound, stemsarray(kds))
    @test length(compoundstems) == 1
    @test inflectionClass(compoundstems[1]) == "w_regular"
    @test stemstring(compoundstems[1]) == nfkc("ἐν#κελευ")
end

@testset "Test composing compound forms" begin
    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset
    compound = LexemeUrn("lsj.n30252")

    pres = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense(1), gmpMood(1), gmpVoice(1)) |> formurn
    presform = generate(compound, pres, kds)[1]
    @test_broken presform == nfkc("ἐγκελεύω")


    impft = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("imperfect"), gmpMood(1), gmpVoice(1)) |> formurn
    impftform = generate(compound, pres, kds)[1]
    @test_broken impftform == nfkc("ἐνεκέλευον")


    fut = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("future"), gmpMood(1), gmpVoice(1)) |> formurn
    futform = generate(compound, pres, kds)[1]
    @test_broken futform == nfkc("ἐγκελεύσω")


    aorind = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("aorist"), gmpMood(1), gmpVoice(1)) |> formurn
    aorindform = generate(compound, pres, kds)[1]
    @test_broken aorindform == nfkc("ἐγκέλευσα")


    aorsubj = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("aorist"), gmpMood("subjunctive"), gmpVoice(1)) |> formurn
    aorsubjform = generate(compound, pres, kds)[1]
    @test_broken aorsubjform == nfkc("ἐγκελεύσω")


    pftact = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("perfect"), gmpMood(1), gmpVoice("active")) |> formurn
    pftactform = generate(compound, pres, kds)[1]
    @test_broken pftactform == nfkc("ἐγκεκέλευκα")

    plupft = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("pluperfect"), gmpMood(1), gmpVoice(1)) |> formurn
    plupftform = generate(compound, pres, kds)[1]
    @test_broken plupftform == nfkc("ἐνεκεκελεύκη")


    pftmp = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("perfect"), gmpMood(1), gmpVoice("passive")) |> formurn
    pftmpform = generate(compound, pres, kds)[1]
    @test_broken pftmpform == nfkc("ἐγκεκέλευμαι")
end