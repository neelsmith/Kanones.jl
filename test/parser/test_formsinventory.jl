@testset "Test computational generation of forms collection" begin
    
    gendercount = keys(Kanones.genderlabeldict) |> length
    casecount = keys(Kanones.caselabeldict) |> length
    numbercount = keys(Kanones.numberlabeldict) |> length
    degreecount = keys(Kanones.degreelabeldict) |> length

    nounforms = Kanones.nounforms()
    @test length(nounforms) == gendercount * casecount * numbercount
    adjforms = Kanones.adjectiveforms()
    @test length(adjforms) ==  gendercount * casecount * numbercount * degreecount
end