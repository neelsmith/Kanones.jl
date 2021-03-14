


@testset "Test composition of complete CEX for all uninflected forms" begin
    uninflectedforms = split(Kanones.uninflectedcex(), "\n")
    @test length(uninflectedforms) == 6
end