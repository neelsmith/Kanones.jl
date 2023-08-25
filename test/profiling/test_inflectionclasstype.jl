@testset "Test `InflectionCategory` type" begin
    repo = pwd() |> dirname
    f = joinpath(repo, "cexcollections", "inflectionclasses-literarygreek.cex")
    inflclasses = Kanones.icfromfile(f)
    @test inflclasses[1] isa InflectionCategory
end