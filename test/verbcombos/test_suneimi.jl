@testset "Test σύνειμι" begin
    repo = pwd() |> dirname
    kds = [joinpath(repo,"datasets","literarygreek-rules"), joinpath(repo, "datasets","lsj-vocab")  ] |> dataset

    #kds = joinpath(repo, "datasets", "literarygreek-rules") |> dataset

    p = stringParser(kds)
    
    @test_broken "??"  == parsetoken("συνεστι", p)
end