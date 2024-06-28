@testset "Test parsing with a string parser" begin
    srcdata = joinpath(dirname(pwd()),"datasets","literarygreek-rules")
    p = dataset(srcdata) |> kanonesStringParser
    @test p isa kanonesStringParser
    
    # Should get a single parse for each of these:
    verb = parsetoken("δείκνυμεν",p)
    noun = parsetoken("δώροις",p)
    adj =  parsetoken("κακή",p)
    infin = parsetoken("κελεύειν",p)
    pronoun = parsetoken("ἡ",p)
    uninfl = parsetoken("καί", p)

    irregnoun = parsetoken("γυνή", p)
    irreginf = parsetoken("εἶναι",p)
    irregadj = parsetoken("πολύς", p)
    irregverb = parsetoken("ἐστι", p)

    @test length(verb) == length(noun) == length(adj) == length(infin) == length(pronoun) == length(uninfl) == length(irregnoun) == length(irreginf) == length(irregadj) == 1

    @test_broken length(irregverb) == 1


    # mid or pass:
    ptcpl =  parsetoken("κελευόμενος",p)
    @test length(ptcpl) == 2
    
    vadj =  parsetoken("κελευτέον",p)
    @test_broken length(vadj) > 1
end