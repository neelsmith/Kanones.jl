@testset "Test τυγχάνω" begin
    repo = pwd() |> dirname
    kds = [joinpath(repo,"datasets","literarygreek-rules"), joinpath(repo, "datasets","lsj-vocab")  ] |> dataset
    p = stringParser(kds)
    
end