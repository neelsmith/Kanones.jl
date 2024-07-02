
@testset "Test IO for delimited text of irregular participles" begin
    delimited = Unicode.normalize("irregptcpl.irregptcpln31130a|lsj.n31130|ὤν|present|active|masculine|nominative|singular|irregularparticiple")
    stem = fromcex(delimited, IrregularParticipleStem)
    @test stem isa IrregularParticipleStem

    

    @test Unicode.normalize(cex(stem)) == delimited
    @test fromcex( Unicode.normalize(cex(stem)), IrregularParticipleStem) == stem
end



@testset "Test data accessors for irregular participles" begin
    delimited = "irregptcpl.irregptcpln31130a|lsj.n31130|ὤν|present|active|masculine|nominative|singular|irregularparticiple"
    stem = fromcex(delimited, IrregularParticipleStem)

    expectedurn = StemUrn("irregptcpl.irregptcpln31130a")
    @test urn(stem) == expectedurn

    dict = Dict("irregptcpl" => "urn:cite2:kanones:irregptcpl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:irregptcpl.v1:irregptcpln31130a")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n31130")
    @test stemstring(stem) == "ὤν"
    @test code(stem) == "5011011100"
    @test Kanones.formurn(stem) == FormUrn("forms.5011011100")
   
    
    @test inflectionclass(stem) == "irregularparticiple"
end