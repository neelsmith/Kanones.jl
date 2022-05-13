
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

    compoundstems = Kanones.stems(compound, kds)
    @test length(compoundstems) == 1
    @test inflectionClass(compoundstems[1]) == "w_regular"
    @test stemstring(compoundstems[1]) == nfkc("ἐγκελευ")
end