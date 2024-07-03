
@testset "Test IO for delimited text of irregular adjectives" begin
    delimited = Unicode.normalize("irregadj.n79904a|lsj.n79904|πᾶς|masculine|nominative|singular|positive|irregularadjective")
    stem = fromcex(delimited, IrregularAdjectiveStem)
    @test stem isa IrregularAdjectiveStem


    @test Unicode.normalize(cex(stem)) == delimited
    @test fromcex(Unicode.normalize(cex(stem)), IrregularAdjectiveStem) == stem

end



@testset "Test data accessors for irregular adjectives" begin
    delimited = "irregadj.n79904a|lsj.n79904|πᾶς|masculine|nominative|singular|positive|irregularadjective"
    stem = fromcex(delimited, IrregularAdjectiveStem)
    expectedurn = StemUrn("irregadj.n79904a")
    @test urn(stem) == expectedurn

    dict = Dict("irregadj" => "urn:cite2:kanones:irregadj.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:irregadj.v1:n79904a")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n79904")
    @test stemstring(stem) == "πᾶς"
    @test code(stem) == "7010001110"
    @test Kanones.formurn(stem) == FormUrn("forms.7010001110")
    
end
