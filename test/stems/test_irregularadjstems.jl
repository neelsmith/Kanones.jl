
@testset "Test IO for delimited text" begin
    delimited = "irregadj.n79904a|lsj.n79904|πᾶς|masculine|nominative|singular|positive|irregularadjective"
    irradjio = Kanones.IrregularAdjectiveIO("IO for irreg adjs")
    stem = Kanones.readstemrow(irradjio, delimited)
    @test stem isa IrregularAdjectiveStem


    @test cex(stem) == "irregadj.n79904a|Irregular adjective form πᾶς (masculine nominative singular positive)|πᾶς|lsj.n79904|irregularadjective|masculine|nominative|singular|positive"

end



@testset "Test data accessors" begin
    delimited = "irregadj.n79904a|lsj.n79904|πᾶς|masculine|nominative|singular|positive|irregularadjective"
    irradjio = Kanones.IrregularAdjectiveIO("IO for irreg adjs")
    stem = Kanones.readstemrow(irradjio, delimited)
    expectedurn = StemUrn("irregadj.n79904a")
    @test urn(stem) == expectedurn

    dict = Dict("irregadj" => "urn:cite2:kanones:irregadj.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:irregadj.v1:n79904a")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n79904")
    @test stemstring(stem) == "πᾶς"
    @test code(stem) == "7010001110"
    @test formurn(stem) == FormUrn("forms.7010001110")
    
end
