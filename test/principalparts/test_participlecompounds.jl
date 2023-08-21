
@testset "Test composing participles of compound verbs" begin
    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset
    compound = LexemeUrn("lsj.n30252")

    
    presact = GMFParticiple(gmpTense(1), gmpVoice(1), gmpGender(1), gmpCase(1), gmpNumber(1)) |> Kanones.formurn
    presactform = generate(compound, presact, kds)[1]
    @test presactform == knormal("ἐγκελεύων")

    presmp = GMFParticiple(gmpTense(1), gmpVoice(2), gmpGender(1), gmpCase(1), gmpNumber(1)) |> Kanones.formurn
    presmpform = generate(compound, presmp, kds)[1]
    @test presmpform == knormal("ἐγκελευόμενος")


    futact = GMFParticiple(gmpTense("future"), gmpVoice(1), gmpGender(1), gmpCase(1), gmpNumber(1)) |> Kanones.formurn
    futactform = generate(compound, futact, kds)[1]
    @test futactform == knormal("ἐγκελεύσων")

    aoract = GMFParticiple(gmpTense("aorist"), gmpVoice(1), gmpGender(1), gmpCase(1), gmpNumber(1)) |> Kanones.formurn
    aoractform = generate(compound, aoract, kds)[1]
    @test aoractform == knormal("ἐγκελεύσας")


    pftact = GMFParticiple(gmpTense("perfect"), gmpVoice(1), gmpGender(1), gmpCase(1), gmpNumber(1)) |> Kanones.formurn
    pftactform = generate(compound, pftact, kds)[1]
    @test pftactform == knormal("ἐγκεκελευκώς")

    pftmp = GMFParticiple(gmpTense("perfect"), gmpVoice(2), gmpGender(1), gmpCase(1), gmpNumber(1)) |> Kanones.formurn
    pftmpform = generate(compound, pftmp, kds)[1]
    @test pftmpform == knormal("ἐγκεκελευμένος")



    aorpass = GMFParticiple(gmpTense("aorist"), gmpVoice("passive"), gmpGender(1), gmpCase(1), gmpNumber(1)) |> Kanones.formurn
    aorpassform = generate(compound, aorpass, kds)[1]
    @test aorpassform == knormal("ἐγκελευσθείς")


    futpass = GMFParticiple(gmpTense("future"), gmpVoice("passive"), gmpGender(1), gmpCase(1), gmpNumber(1)) |> Kanones.formurn
    futpassform = generate(compound, futpass, kds)[1]
    @test futpassform == knormal("ἐγκελευσθησόμενος")
end