@testset "Test working with datasets in files" begin
    repo = pwd() |> dirname
    ds = joinpath(repo, "datasets", "literarygreek-rules")
    kds = Kanones.FilesDataset([ds])
    @test kds isa Kanones.FilesDataset

    @test ! isempty(stemsarray(kds))
    @test ! isempty(rulesarray(kds))
end