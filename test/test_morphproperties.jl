

@testset "Test GMPTense" begin
    tense = gmpTense("present")
    @test isa(tense, GMPTense)
end

@testset "Test GMPMood" begin
    mood = gmpMood("optative")
    @test isa(mood, GMPMood)
end


@testset "Test GMPVoice" begin
    vc = gmpVoice("middle")
    @test isa(vc, GMPVoice)
end


@testset "Test GMPPerson" begin
    pers = gmpPerson("third")
    @test isa(pers, GMPPerson)
end


@testset "Test GMPNumber" begin
    num = gmpNumber("singular")
    @test isa(num, GMPNumber)
end

# gender
# case
# degree