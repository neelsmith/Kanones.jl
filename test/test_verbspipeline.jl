@testset "Test formation of finite verb forms" begin
    ortho = literaryGreek()

    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset
    p = KanonesStringParser(kds)


    pp1 = parsetoken("κελεύομεν",p)[1]
    @test "finite verb:  present indicative active first plural" == label(greekForm(pp1))
    mp = parsetoken("κελευόμεθα",p)
    @test length(mp) == 2

    aug = parsetoken("ἐκέλευες", p)[1]
    @test "finite verb:  imperfect indicative active second singular" == label(greekForm(aug))

    fut = parsetoken("κελεύσονται",p)[1]
    @test "finite verb:  future indicative middle third plural" == label(greekForm(fut))

    aor = parsetoken("ἐκελεύσατο",p)[1]
    @test "finite verb:  aorist indicative middle third singular" == label(greekForm(aor))


    pft = parsetoken("κεκέλευκε",p)[1]
    @test "finite verb:  perfect indicative active third singular" == label(greekForm(pft))

    pp5mp = parsetoken("κεκέλευται",p)
    @test length(pp5mp) == 2
    pp5form = greekForm(pp5mp[1])
    @test label(gmpTense(pp5form)) == "perfect"
    @test label(gmpPerson(pp5form)) == "third"
    @test label(gmpNumber(pp5form)) == "singular"
    @test label(gmpMood(pp5form)) == "indicative"
    @test (label(gmpVoice(pp5form)) == "middle") || (label(gmpVoice(pp5form)) == "passive")

    plpft = parsetoken("ἐκεκελεύκει",p)[1]
    @test "finite verb:  pluperfect indicative active third singular" == plpft |> greekForm |> label

    pp6 = parsetoken("ἐκελεύσθη", p)[1]
    @test "finite verb:  aorist indicative passive third singular" == label(greekForm(pp6))

    # test augment of second aorist
    aor2 = parsetoken("ἔτυχε",p)[1]
    @test "finite verb:  aorist indicative active third singular" == label(greekForm(aor2))

    # test augment of pluperfect
    # test compounding
    # test temporal augment
    tempaugimpft = parsetoken("ἦρχε",p)[1]
    @test "finite verb:  imperfect indicative active third singular" == label(greekForm(tempaugimpft))
    
    tempaugaor = parsetoken("ἦρξε",p)[1]
    @test "finite verb:  aorist indicative active third singular" == label(greekForm(tempaugaor))

    # test phonetic changes in perfect stems
    tempaugmp = parsetoken("ἦρκται",p)
    tempaugform = greekForm(tempaugmp[1])
    @test label(gmpTense(pp5form)) == "perfect"
    @test label(gmpPerson(pp5form)) == "third"
    @test label(gmpNumber(pp5form)) == "singular"
    @test label(gmpMood(pp5form)) == "indicative"
    @test (label(gmpVoice(pp5form)) == "middle") || (label(gmpVoice(pp5form)) == "passive")

    # test irregular verbs
    irreg = parsetoken("εἴη",p)[1]
    @test "finite verb:  present optative active third singular" == label(greekForm(irreg))
end


@testset "Test formation of inifinitive verb forms" begin
    ortho = literaryGreek()
    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset
    p = KanonesStringParser(kds)

    presact = parsetoken("κελεύειν",p)[1]
    @test "infinitive: present active" == label(greekForm(presact))

    futmid =  parsetoken("κελεύσεσθαι",p)[1]
    @test "infinitive: future middle" == label(greekForm(futmid))

    aormid = parsetoken("κελεύσασθαι",p)[1]
    @test "infinitive: aorist middle" == label(greekForm(aormid))

    pftact = parsetoken("κεκελευκέναι",p)[1] 
    @test "infinitive: perfect active" == label(greekForm(pftact))

    aorpass = parsetoken("κελευσθῆναι",p)[1]
    @test  "infinitive: aorist passive" == label(greekForm(aorpass))

    irreg = parsetoken("εἶναι",p)[1] 
    @test "infinitive: present active" == label(greekForm(irreg))
end


@testset "Test formation of participles" begin

end