@testset "Test computational generation of forms collection" begin
    
    gendercount = keys(Kanones.genderlabeldict) |> length
    casecount = keys(Kanones.caselabeldict) |> length
    numbercount = keys(Kanones.numberlabeldict) |> length
    degreecount = keys(Kanones.degreelabeldict) |> length

    nounforms = Kanones.nounforms()
    @test typeof(nounforms) == Vector{GMFNoun}
    @test length(nounforms) == gendercount * casecount * numbercount

    pronounforms = Kanones.pronounforms()
    @test typeof(pronounforms) == Vector{GMFPronoun}
    @test length(pronounforms) == gendercount * casecount * numbercount

    adjforms = Kanones.adjectiveforms()
    @test typeof(adjforms) ==  Vector{GMFAdjective}
    @test length(adjforms) ==  gendercount * casecount * numbercount * degreecount

    vadjforms = Kanones.verbaladjectiveforms()
    @test typeof(vadjforms) == Vector{GMFVerbalAdjective}
    @test length(vadjforms) ==  gendercount * casecount * numbercount

    voicecount = keys(Kanones.voicelabeldict) |> length
    infinitivetenses = 4
    infforms = Kanones.infinitiveforms()
    @test typeof(infforms) == Vector{GMFInfinitive}
    @test length(infforms) == infinitivetenses * voicecount

    ptcpltenses = [
        Kanones.tensecodedict["present"],
        Kanones.tensecodedict["future"],
        Kanones.tensecodedict["aorist"],
        Kanones.tensecodedict["perfect"]
    ]

    ptcplforms = Kanones.participleforms()
    @test typeof(ptcplforms) == Vector{GMFParticiple}
    @test length(ptcplforms) == length(ptcpltenses) * voicecount * gendercount * casecount * numbercount

end