@testset "Test formation of finite verb forms" begin
    ortho = literaryGreek()

    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset
    p = stringParser(kds)


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
    @test "finite verb:  perfect indicative active third singular" == label(greekForm(aχ))


    # test augment of second aorist
    # test augment of pluperfect
    # test reduplication in perfect
    # test compounding
    # test temporal augment
    # test phonetic changes in perfect stems
    # test irregular verbs
end