@testset "Format fst rules for verb tokens" begin
    cexsrc = "verbinfl.wreg3rd1|w_regular|ει|3rd|singular|present|indicative|active"
    verbio = Kanones.VerbIO("verbs")
    rulerow = Kanones.readrulerow(verbio, cexsrc)
    expected = "<w_regular><finiteverb>ει<3rd><singular><present><indicative><active><u>verbinfl\\.wreg3rd1</u>"

    
    @test FstBuilder.fst(rulerow) == expected
end


@testset "Format fst lexicon for regular verb stems" begin
    cexsrc = "verbstems.n56496|lexent.n56496|κελευ|w_regular|"
    verbio = Kanones.VerbIO("verbs")
    stem = Kanones.readstemrow(verbio, cexsrc)
    expected = "<u>verbstems\\.n56496</u><u>lexent\\.n56496</u><stem>κελευ<finiteverb><w_regular>"
    @test FstBuilder.fst(stem) == expected
end

@testset "Format fst lexicon for irregular verb stems" begin
end


#=
@testset "Parse rule component FST reply into a form URN" begin
    rule = "<w_regular><finiteverb>ει<third><singular><present><indicative><active>"
    expected = FormUrn("morphforms.3031111000")
    @test Kanones.finiteverbruleurn(rule) == expected
end
=#