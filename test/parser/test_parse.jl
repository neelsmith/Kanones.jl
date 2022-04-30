@testset "Test parsing with a string parser" begin
    srcdata = joinpath(dirname(pwd()),"datasets","lg-core")
    p = dataset(srcdata) |> stringParser
    @test p isa StringParser
    
    # Should get a single parse for each of these:
    verb = parsetoken("δείκνυμεν",p)
    noun = parsetoken("δώροις",p)
    adj =  parsetoken("κακή",p)
    infin = parsetoken("κελεύειν",p)
    pronoun = parsetoken("ἡ",p)
    uninfl = parsetoken("καί", p)
    
    @test length(verb) == length(noun) == length(adj) == length(infin) == length(pronoun) == length(uninfl) == 1
    # mid or pass:
    ptcpl =  parsetoken("κελευόμενος",p)
    @test length(ptcpl) == 2
    
    vadj =  parsetoken("κελευτέον",p)
    @test length(vadj) > 1
end