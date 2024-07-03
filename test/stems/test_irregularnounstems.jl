
#

@testset "Test IO for delimited text" begin
    delimited = Unicode.normalize("irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun")
    stem = fromcex(delimited, IrregularNounStem)
    @test stem isa IrregularNounStem


    @test cex(stem) ==  delimited
    @test fromcex(cex(stem), IrregularNounStem) == stem
end

@testset "Test data accessors" begin
    delimited = "irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun"
    stem = fromcex(delimited, IrregularNounStem)
    expectedurn = StemUrn("irregnoun.irregn23069a")
    @test urn(stem) == expectedurn

    dict = Dict("irregnoun" => "urn:cite2:kanones:irregnoun.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:irregnoun.v1:irregn23069a")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n23069")
    @test stemstring(stem) == "γυνή"
    @test code(stem) == "2010002100"
    @test Kanones.formurn(stem) == FormUrn("forms.2010002100")
    
end
