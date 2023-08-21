

@testset "Test composing infinitives of compound verbs" begin
    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset
    compound = LexemeUrn("lsj.n30252")
    
    presact = GMFInfinitive(gmpTense(1), gmpVoice(1)) |> Kanones.formurn
    presactform = generate(compound, presact, kds)[1]
    @test presactform == knormal("ἐγκελεύειν")


    futact = GMFInfinitive(gmpTense("future"), gmpVoice(1)) |> Kanones.formurn
    futactform = generate(compound, futact, kds)[1]
    @test futactform == knormal("ἐγκελεύσειν")

    futmid = GMFInfinitive(gmpTense("future"), gmpVoice("middle")) |> Kanones.formurn
    futmidform = generate(compound, futmid, kds)[1]
    @test futmidform == knormal("ἐγκελεύσεσθαι")


    aoract = GMFInfinitive(gmpTense("aorist"), gmpVoice(1)) |> Kanones.formurn
    aoractform = generate(compound, aoract, kds)[1]
    @test aoractform == knormal("ἐγκελεῦσαι")


    aormid = GMFInfinitive(gmpTense("aorist"), gmpVoice(2)) |> Kanones.formurn
    aormidform = generate(compound, aormid, kds)[1]
    @test aormidform == knormal("ἐγκελεύσασθαι")



    pftact = GMFInfinitive(gmpTense("perfect"), gmpVoice(1)) |> Kanones.formurn
    pftactform = generate(compound, pftact, kds)[1]
    @test pftactform == knormal("ἐγκεκελευκέναι")


    pftmp = GMFInfinitive(gmpTense("perfect"), gmpVoice(2)) |> Kanones.formurn
    pftmpform = generate(compound, pftmp, kds)[1]
    @test pftmpform == knormal("ἐγκεκελεύσθαι")


    futpass = GMFInfinitive(gmpTense("future"), gmpVoice("passive")) |> Kanones.formurn
    futpassform = generate(compound, futpass, kds)[1]
    @test futpassform == knormal("ἐγκελευσθήσεσθαι")


    aorpass = GMFInfinitive(gmpTense("aorist"), gmpVoice(3)) |> Kanones.formurn
    aorpassform = generate(compound, aorpass, kds)[1]
    @test aorpassform == knormal("ἐγκελευσθῆναι")
end
