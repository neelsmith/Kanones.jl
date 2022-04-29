@testset "Test computational generation of forms collection" begin
    
    gendercount = keys(Kanones.genderlabeldict) |> length
    casecount = keys(Kanones.caselabeldict) |> length
    numbercount = keys(Kanones.numberlabeldict) |> length
    degreecount = keys(Kanones.degreelabeldict) |> length

    nounforms = Kanones.nounforms()
    @test typeof(nounforms) == Vector{GMFNoun}
    @test length(nounforms) == gendercount * casecount * numbercount

    adjforms = Kanones.adjectiveforms()
    @test typeof(adjforms) ==  Vector{GMFAdjective}
    @test length(adjforms) ==  gendercount * casecount * numbercount * degreecount

    vadjforms = Kanones.verbaladjectiveforms()
    @test typeof(vadjforms) == Vector{GMFVerbalAdjective}
    @test length(vadjforms) ==  gendercount * casecount * numbercount

end