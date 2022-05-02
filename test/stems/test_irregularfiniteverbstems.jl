
@testset "Test IO for delimited text" begin
    delimited = "irregverb.irregverbn31130a1|lsj.n31130|ἐστι|third|singular|present|indicative|active|irregularfiniteverb"
    irrverbio = Kanones.IrregularVerbIO("IO for irreg verbs")
    stem = Kanones.readstemrow(irrverbio, delimited)
    @test stem isa IrregularVerbStem


    @test cex(stem) == "irregverb.irregverbn31130a1|Irregular verb form ἐστι (third singular present indicative active)|ἐστι|lsj.n31130|irregularfiniteverb|third|singular|present|indicative|active"


end



@testset "Test data accessors" begin
    delimited = "irregverb.irregverbn31130a1|lsj.n31130|ἐστι|third|singular|present|indicative|active|irregularfiniteverb"
    irrverbio = Kanones.IrregularVerbIO("IO for irreg verbs")
    stem = Kanones.readstemrow(irrverbio, delimited)
    expectedurn = StemUrn("irregverb.irregverbn31130a1")
    @test urn(stem) == expectedurn

    dict = Dict("irregverb" => "urn:cite2:kanones:irregverb.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:irregverb.v1:irregverbn31130a1")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexeme(stem) == LexemeUrn("lsj.n31130")
    @test stemstring(stem) == "ἐστι"
    @test code(stem) == "3311110000"
    @test formurn(stem) == FormUrn("forms.3311110000")
    
end
