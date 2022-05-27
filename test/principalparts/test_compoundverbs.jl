
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

@testset "Test composing finite forms of compound verbs" begin
    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset
    compound = LexemeUrn("lsj.n30252")

    pres = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense(1), gmpMood(1), gmpVoice(1)) |> formurn
    presform = generate(compound, pres, kds)[1]
    @test presform == nfkc("ἐγκελεύω")


    impft = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("imperfect"), gmpMood(1), gmpVoice(1)) |> formurn
    impftform = generate(compound, impft, kds)[1]
    @test impftform == nfkc("ἐνεκέλευον")


    fut = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("future"), gmpMood(1), gmpVoice(1)) |> formurn
    futform = generate(compound, fut, kds)[1]
    @test futform == nfkc("ἐγκελεύσω")


    aorind = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("aorist"), gmpMood(1), gmpVoice(1)) |> formurn
    aorindform = generate(compound, aorind, kds)[1]
    @test aorindform == nfkc("ἐνεκέλευσα")


    aorsubj = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("aorist"), gmpMood("subjunctive"), gmpVoice(1)) |> formurn
    aorsubjform = generate(compound, aorsubj, kds)[1]
    @test aorsubjform == nfkc("ἐγκελεύσω")


    pftact = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("perfect"), gmpMood(1), gmpVoice("active")) |> formurn
    pftactform = generate(compound, pftact, kds)[1]
    @test pftactform == nfkc("ἐγκεκέλευκα")

    plupft = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("pluperfect"), gmpMood(1), gmpVoice(1)) |> formurn
    plupftform = generate(compound, plupft, kds)[1]
    @test plupftform == nfkc("ἐνεκεκελεύκη")


    pftmp = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("perfect"), gmpMood(1), gmpVoice("passive")) |> formurn
    pftmpform = generate(compound, pftmp, kds)[1]
    @test pftmpform == nfkc("ἐγκεκέλευμαι")

    aorpass = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("aorist"), gmpMood(1), gmpVoice("passive")) |> formurn
    aorpassform = generate(compound, aorpass, kds)[1]
    @test aorpassform == nfkc("ἐνεκελεύθην")


    futpass = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("future"), gmpMood(1), gmpVoice("passive")) |> formurn
    futpassform = generate(compound, futpass, kds)[1]
    @test futpassform == nfkc("ἐγκελευθήσομαι")

end

@testset "Test composing infinitives of compound verbs" begin
    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset
    compound = LexemeUrn("lsj.n30252")
    
    presact = GMFInfinitive(gmpTense(1), gmpVoice(1)) |> formurn
    presactform = generate(compound, presact, kds)[1]
    @test presactform == nfkc("ἐγκελεύειν")


    futact = GMFInfinitive(gmpTense("future"), gmpVoice(1)) |> formurn
    futactform = generate(compound, futact, kds)[1]
    @test futactform == nfkc("ἐγκελεύσειν")

    futmid = GMFInfinitive(gmpTense("future"), gmpVoice("middle")) |> formurn
    futmidform = generate(compound, futmid, kds)[1]
    @test futmidform == nfkc("ἐγκελεύσεσθαι")


    aoract = GMFInfinitive(gmpTense("aorist"), gmpVoice(1)) |> formurn
    aoractform = generate(compound, aoract, kds)[1]
    @test aoractform == nfkc("ἐγκελεῦσαι")


    aormid = GMFInfinitive(gmpTense("aorist"), gmpVoice(2)) |> formurn
    aormidform = generate(compound, aormid, kds)[1]
    @test aormidform == nfkc("ἐγκελεύσασθαι")



    pftact = GMFInfinitive(gmpTense("perfect"), gmpVoice(1)) |> formurn
    pftactform = generate(compound, pftact, kds)[1]
    @test pftactform == nfkc("ἐγκεκελευκέναι")


    pftmp = GMFInfinitive(gmpTense("perfect"), gmpVoice(2)) |> formurn
    pftmpform = generate(compound, pftmp, kds)[1]
    @test pftmpform == nfkc("ἐγκεκελεύσθαι")


    futpass = GMFInfinitive(gmpTense("future"), gmpVoice("passive")) |> formurn
    futpassform = generate(compound, futpass, kds)[1]
    @test futpassform == nfkc("ἐγκελευθήσεσθαι")


    aorpass = GMFInfinitive(gmpTense("aorist"), gmpVoice(3)) |> formurn
    aorpassform = generate(compound, aorpass, kds)[1]
    @test aorpassform == nfkc("ἐγκελευθῆναι")
end

@testset "Test composing verbal adjectives  of compound verbs" begin
    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset
    compound = LexemeUrn("lsj.n30252")

    vadj = GMFVerbalAdjective(gmpGender("neuter"), gmpCase("accusative"), gmpNumber(1)) |> formurn
    vadjform = generate(compound, vadj, kds)[1]
    @test vadjform = nfkc("ἐγκελευτέον")
    
end


@testset "Test composing participles of compound verbs" begin
    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset
    compound = LexemeUrn("lsj.n30252")

    
    presact = GMFParticiple(gmpTense(1), gmpVoice(1), gmpGender(1), gmpCase(1), gmpNumber(1)) |> formurn
    presactform = generate(compound, presact, kds)[1]
    @test presactform == nfkc("ἐγκελεύων")

    presmp = GMFParticiple(gmpTense(1), gmpVoice(2), gmpGender(1), gmpCase(1), gmpNumber(1)) |> formurn
    presmpform = generate(compound, presmp, kds)[1]
    @test presmpform == nfkc("ἐγκελευόμενος")


    futact = GMFParticiple(gmpTense("future"), gmpVoice(1), gmpGender(1), gmpCase(1), gmpNumber(1)) |> formurn
    futactform = generate(compound, futact, kds)[1]
    @test futactform == nfkc("ἐγκελεύσων")

    aoract = GMFParticiple(gmpTense("aorist"), gmpVoice(1), gmpGender(1), gmpCase(1), gmpNumber(1)) |> formurn
    aoractform = generate(compound, aoract, kds)[1]
    @test aoractform == nfkc("ἐγκέλευσας")


    pftact = GMFParticiple(gmpTense("perfect"), gmpVoice(1), gmpGender(1), gmpCase(1), gmpNumber(1)) |> formurn
    pftactform = generate(compound, pftact, kds)[1]
    @test pftactform == nfkc("ἐγκεκελευκώς")

    pftmp = GMFParticiple(gmpTense("perfect"), gmpVoice(2), gmpGender(1), gmpCase(1), gmpNumber(1)) |> formurn
    pftmpform = generate(compound, pftmp, kds)[1]
    @test pftmpform == nfkc("ἐγκεκελευμένος")



    aorpass = GMFParticiple(gmpTense("aorist"), gmpVoice("passive"), gmpGender(1), gmpCase(1), gmpNumber(1)) |> formurn
    aorpassform = generate(compound, aorpass, kds)[1]
    @test aorpassform == nfkc("ἐγκελευθεῖς")


    futpass = GMFParticiple(gmpTense("future"), gmpVoice("passive"), gmpGender(1), gmpCase(1), gmpNumber(1)) |> formurn
    futpassform = generate(compound, futpass, kds)[1]
    @test futpassform == nfkc("ἐγκελευθησόμενος")
end