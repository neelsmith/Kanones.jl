
@testset "Test IO for delimited text" begin
    delimited = Unicode.normalize("irreginf.irreginfln31130|lsj.n31130|εἶναι|present|active|irregularinfinitive")
    stem = fromcex(delimited, IrregularInfinitiveStem)
    @test stem isa IrregularInfinitiveStem


    @test Unicode.normalize(cex(stem)) == Unicode.normalize("irreginf.irreginfln31130|lsj.n31130|εἶναι|present|active|irregularinfinitive")
    @test fromcex(Unicode.normalize(cex(stem)), IrregularInfinitiveStem) == stem

end


@testset "Test data accessors" begin
    delimited = "irreginf.irreginfln31130|lsj.n31130|εἶναι|present|active|irregularinfinitive"
    stem = fromcex(delimited, IrregularInfinitiveStem)
    expectedurn = StemUrn("irreginf.irreginfln31130")
    @test urn(stem) == expectedurn

    dict = Dict("irreginf" => "urn:cite2:kanones:irreginf.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:irreginf.v1:irreginfln31130")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n31130")
    @test stemstring(stem) == "εἶναι"
    @test code(stem) == "4001010000"
    @test Kanones.formurn(stem) == FormUrn("forms.4001010000")
    
end
