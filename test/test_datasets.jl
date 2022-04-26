@testset "Test working with datasets in files" begin
    repo = pwd() |> dirname
    ds = joinpath(repo, "datasets", "lg-core")
    kds = Kanones.dataset([ds])
    @test kds isa Kanones.Dataset

    @test ! isempty(stemsarray(kds))
    @test ! isempty(rulesarray(kds))
end