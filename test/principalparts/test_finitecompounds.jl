
@testset "Test composing finite forms of compound verbs" begin
    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset
    compound = LexemeUrn("lsj.n30252")

    pres = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense(1), gmpMood(1), gmpVoice(1)) |> Kanones.formurn
    presform = generate(compound, pres, kds)[1]
    @test presform == knormal("ἐγκελεύω")


    impft = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("imperfect"), gmpMood(1), gmpVoice(1)) |> Kanones.formurn
    impftform = generate(compound, impft, kds)[1]
    @test impftform == knormal("ἐνεκέλευον")


    fut = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("future"), gmpMood(1), gmpVoice(1)) |> Kanones.formurn
    futform = generate(compound, fut, kds)[1]
    @test futform == knormal("ἐγκελεύσω")


    aorind = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("aorist"), gmpMood(1), gmpVoice(1)) |> Kanones.formurn
    aorindform = generate(compound, aorind, kds)[1]
    @test aorindform == knormal("ἐνεκέλευσα")


    aorsubj = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("aorist"), gmpMood("subjunctive"), gmpVoice(1)) |> Kanones.formurn
    aorsubjform = generate(compound, aorsubj, kds)[1]
    @test aorsubjform == knormal("ἐγκελεύσω")


    pftact = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("perfect"), gmpMood(1), gmpVoice("active")) |> Kanones.formurn
    pftactform = generate(compound, pftact, kds)[1]
    @test pftactform == knormal("ἐγκεκέλευκα")

    plupft = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("pluperfect"), gmpMood(1), gmpVoice(1)) |> Kanones.formurn
    plupftform = generate(compound, plupft, kds)[1]
    @test plupftform == knormal("ἐνεκεκελεύκη")


    pftmp = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("perfect"), gmpMood(1), gmpVoice("passive")) |> Kanones.formurn
    pftmpform = generate(compound, pftmp, kds)[1]
    @test pftmpform == knormal("ἐγκεκέλευμαι")

    aorpass = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("aorist"), gmpMood(1), gmpVoice("passive")) |> Kanones.formurn
    aorpassform = generate(compound, aorpass, kds)[1]
    @test aorpassform == knormal("ἐνεκελεύθην")


    futpass = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("future"), gmpMood(1), gmpVoice("passive")) |> Kanones.formurn
    futpassform = generate(compound, futpass, kds)[1]
    @test futpassform == knormal("ἐγκελευθήσομαι")

end