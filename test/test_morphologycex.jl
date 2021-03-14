


@testset "Test composition of complete CEX for all uninflected forms" begin
    uninflectedforms = split(Kanones.uninflectedcex(), "\n")
    @test length(uninflectedforms) == 6
end


@testset "Test compostion of CEX for uninflected form" begin
    uform = UninflectedForm(1, "conjunction")
    @test Kanones.cex(uform) == "urn:cite2:kanones:morphforms.v1:1000000001|uninflected form: conjunction"
end