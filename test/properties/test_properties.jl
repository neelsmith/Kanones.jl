@testset "Test labelling and codes for person property" begin
    @test gmpPerson(1) == gmpPerson("first")
end