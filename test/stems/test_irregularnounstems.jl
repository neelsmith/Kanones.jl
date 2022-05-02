
#

@testset "Test IO for delimited text" begin
    delimited = "irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun"
    irrnounio = Kanones.IrregularNounIO("IO for irreg nouns")
    stem = Kanones.readstemrow(irrnounio, delimited)
    @test stem isa IrregularNounStem


    @test cex(stem) == "irregnoun.irregn23069a|Irregular noun form γυνή (feminine nominative singular)|γυνή|lsj.n23069|irregularnoun|feminine|nominative|singular"

end

@testset "Test data accessors" begin
    delimited = "irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun"
    irrnounio = Kanones.IrregularNounIO("IO for irreg nouns")
    stem = Kanones.readstemrow(irrnounio, delimited)
    expectedurn = StemUrn("irregnoun.irregn23069a")
    @test urn(stem) == expectedurn

    dict = Dict("irregnoun" => "urn:cite2:kanones:irregnoun.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:irregnoun.v1:irregn23069a")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n23069")
    @test stemstring(stem) == "γυνή"
    @test code(stem) == "2010002100"
    @test formurn(stem) == FormUrn("forms.2010002100")
    
end
