
@testset "Test parsing delimited text for a compound verb stem" begin
    s = "compounds.n30252|lsj.n30252|ἐν|lsj.n56496|ἐγκελεύω|"
    compound = compoundstem(s)
    @test compound isa CompoundVerbStem

    @test lexemeurn(compound) == LexemeUrn("lsj.n30252")

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

@testset "Test composing verbal adjectives  of compound verbs" begin
    repo = pwd() |> dirname
    kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset
    compound = LexemeUrn("lsj.n30252")

    vadj = GMFVerbalAdjective(gmpGender("neuter"), gmpCase("accusative"), gmpNumber(1)) |> Kanones.formurn
    vadjform = generate(compound, vadj, kds)[1]
    @test vadjform == knormal("ἐγκελευστέον")
    
end

