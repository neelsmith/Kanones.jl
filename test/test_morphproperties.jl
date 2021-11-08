@testset "Test GMPVoice" begin
    vc = gmpVoice("middle")
    @test isa(vc, GMPVoice)

end


@testset "Test GMPMood" begin
    mood = gmpMood("optative")
    @test isa(mood, GMPMood)

end