@testset ExtendedTestSet "Format fst rules for verb tokens" begin
    cexsrc = "verbinfl.wreg3rd1|w_regular|ει|third|singular|present|indicative|active"
    verbio = Kanones.VerbIO("verbs")
    rulerow = Kanones.readrulerow(verbio, cexsrc)
    expected = "<w_regular><finiteverb>ει<third><singular><present><indicative><active><u>verbinfl\\.wreg3rd1</u>"

    
    @test FstBuilder.fst(rulerow) == expected
end


@testset ExtendedTestSet "Format fst lexicon for regular verb stems" begin
    cexsrc = "irregverb.n110639a|lsj.n110639|φησί|third|singular|present|indicative|active|irregularverb"
    verbio = Kanones.IrregularVerbIO("verbs")
    stem = Kanones.readstemrow(verbio, cexsrc)
    expected = "<u>irregverb\\.n110639a</u><u>lsj\\.n110639</u>φησι<irregular><irregularfiniteverb><third><singular><present><indicative><active>"
    @test FstBuilder.fst(stem) == expected
end

@testset ExtendedTestSet "Format fst lexicon for irregular verb stems" begin
    cexsrc = "irregverb.n110639a|lsj.n110639|φησί|third|singular|present|indicative|active|irregularverb"
    verbio = Kanones.IrregularVerbIO("verbs")
    stem = Kanones.readstemrow(verbio, cexsrc)
    expected = "<u>irregverb\\.n110639a</u><u>lsj\\.n110639</u>φησι<irregular><irregularfiniteverb><third><singular><present><indicative><active>"
    @test FstBuilder.fst(stem) == expected
end


#=
@testset "Parse rule component FST reply into a form URN" begin
    rule = "<w_regular><finiteverb>ει<third><singular><present><indicative><active>"
    expected = FormUrn("morphforms.3031111000")
    @test Kanones.finiteverbruleurn(rule) == expected
end
=#