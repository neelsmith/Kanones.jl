@testset "Test parsing with a string parser" begin
    srcdata = joinpath(dirname(pwd()),"datasets","lg-core")
    p = dataset(srcdata) |> stringParser
    @test p isa StringParser
    
end