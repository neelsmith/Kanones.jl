
@testset "Test IO for delimited text" begin
    delimited = Unicode.normalize("irregverb.irregverbn31130a1|lsj.n31130|ἐστι|third|singular|present|indicative|active|irregularfiniteverb")
    stem = fromcex(delimited, IrregularVerbStem)
    @test stem isa IrregularVerbStem


    @test Unicode.normalize(cex(stem)) == Unicode.normalize("irregverb.irregverbn31130a1|lsj.n31130|ἐστι|third|singular|present|indicative|active|irregularfiniteverb")

    @test fromcex(Unicode.normalize(cex(stem)), IrregularVerbStem) == stem


end

@testset "Test data accessors" begin
    delimited = "irregverb.irregverbn31130a1|lsj.n31130|ἐστι|third|singular|present|indicative|active|irregularfiniteverb"
    stem = fromcex(delimited, IrregularVerbStem)
    expectedurn = StemUrn("irregverb.irregverbn31130a1")
    @test urn(stem) == expectedurn

    dict = Dict("irregverb" => "urn:cite2:kanones:irregverb.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:irregverb.v1:irregverbn31130a1")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n31130")
    @test Unicode.normalize(stemstring(stem)) == Unicode.normalize("ἐστι")
    @test code(stem) == "3311110000"
    @test Kanones.formurn(stem) == FormUrn("forms.3311110000")
    
end
