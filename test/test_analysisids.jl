@testset ExtendedTestSet "Test working with lexemes" begin
    @test_broken "Analysis" == "citable thing"
end


@testset ExtendedTestSet "Test working with rules" begin
    cexsrc = "nouninfl.h_hs2|h_hs|ης|feminine|genitive|singular|recessive"
    nounparser = Kanones.NounIO("nouns")
    rule = Kanones.readrulerow(nounparser, cexsrc)
    @test_broken rule == "citable thing"
end

@testset ExtendedTestSet "Test working with stems" begin
    cexsrc = "nounstems.n22502|lexent.n22502|γνωμ|feminine|h_hs|recessive|"
    nounparser = Kanones.NounIO("nouns")
    stem = Kanones.readstemrow(nounparser, cexsrc)
    @test_broken stem == "citable thing"


    cexirreg = "irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun"
    irregparser = Kanones.IrregularNounIO("irregular nouns")
    irregstem = Kanones.readstemrow(irregparser, cexirreg)
    @test_broken irregstem == "citable thing"
end
