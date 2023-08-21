
@testset "Test parsing delimited text for a compound verb stem" begin
    s = "compounds.n30252|lsj.n30252|ἐν|lsj.n56496|ἐγκελεύω|"
    compound = compoundstem(s)
    @test compound isa CompoundVerbStem

    @test lexeme(compound) == LexemeUrn("lsj.n30252")

    @test simplex(compound) == LexemeUrn("lsj.n56496")

    @test prefix(compound) == knormal("ἐν")
end

@testset "Test constructing stem objects for compound verb" begin
    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset

    s = "compounds.n30252|lsj.n30252|ἐν|lsj.n56496|ἐγκελεύω|"
    compound = compoundstem(s)

    compoundstems = Kanones.stems(compound, stemsarray(kds))
    @test length(compoundstems) == 6
    @test inflectionclass(compoundstems[1]) == "w_pp1"
    @test stemstring(compoundstems[1]) == knormal("ἐν#κελευ")
end


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
    @test futpassform == knormal("ἐγκελευθήσεσθαι")


    aorpass = GMFInfinitive(gmpTense("aorist"), gmpVoice(3)) |> Kanones.formurn
    aorpassform = generate(compound, aorpass, kds)[1]
    @test aorpassform == knormal("ἐγκελευθῆναι")
end

@testset "Test composing verbal adjectives  of compound verbs" begin
    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset
    compound = LexemeUrn("lsj.n30252")

    vadj = GMFVerbalAdjective(gmpGender("neuter"), gmpCase("accusative"), gmpNumber(1)) |> Kanones.formurn
    vadjform = generate(compound, vadj, kds)[1]
    @test vadjform == knormal("ἐγκελευτέον")
    
end


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
    @test aoractform == knormal("ἐγκέλευσας")


    pftact = GMFParticiple(gmpTense("perfect"), gmpVoice(1), gmpGender(1), gmpCase(1), gmpNumber(1)) |> Kanones.formurn
    pftactform = generate(compound, pftact, kds)[1]
    @test pftactform == knormal("ἐγκεκελευκώς")

    pftmp = GMFParticiple(gmpTense("perfect"), gmpVoice(2), gmpGender(1), gmpCase(1), gmpNumber(1)) |> Kanones.formurn
    pftmpform = generate(compound, pftmp, kds)[1]
    @test pftmpform == knormal("ἐγκεκελευμένος")



    aorpass = GMFParticiple(gmpTense("aorist"), gmpVoice("passive"), gmpGender(1), gmpCase(1), gmpNumber(1)) |> Kanones.formurn
    aorpassform = generate(compound, aorpass, kds)[1]
    @test aorpassform == knormal("ἐγκελευθεῖς")


    futpass = GMFParticiple(gmpTense("future"), gmpVoice("passive"), gmpGender(1), gmpCase(1), gmpNumber(1)) |> Kanones.formurn
    futpassform = generate(compound, futpass, kds)[1]
    @test futpassform == knormal("ἐγκελευθησόμενος")
end