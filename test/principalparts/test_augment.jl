@testset "Test syllabic and temporal augment" begin
    repo = pwd() |> dirname
    kds = [joinpath(repo,"datasets","literarygreek-rules"), joinpath(repo, "datasets","lsj-vocab")  ] |> dataset

    αθετεω = LexemeUrn("lsj.n1965")
    aorind = GMFFiniteVerb(gmpPerson(1), gmpNumber(1), gmpTense("aorist"), gmpMood(1), gmpVoice(1)) |> Kanones.formurn

    @test_broken "" == generate(αθετεω, aorind, kds)
end