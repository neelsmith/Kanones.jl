@testset "Test GMPVoice" begin
    vc = gmpVoice("middle")
    @test isa(vc, GMPVoice)

end