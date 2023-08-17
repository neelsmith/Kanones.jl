@testset "Test normalization to canonical form for Kanones analysis" begin
    lg = literaryGreek()
    resolved1 = resolvestring("ἔγωγε", lg)
    @test length(resolved1) == 2

    @test resolvestring("κἀκεῖ") == ["καί", "ἐκεῖ"]

    @test resolvestring("ἐκεῖνός")  == ["ἐκεῖνος"]

    @test resolvestring("βουλὴ")  == ["βουλή"]

end