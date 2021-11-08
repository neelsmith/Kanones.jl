@testset "Read rules for noun tokens from delimited text" begin
    cexsrc = "nouninfl.h_hs2|h_hs|ης|feminine|genitive|singular|recessive"
    nounparser = Kanones.NounIO("nouns")
    rule = Kanones.readrulerow(nounparser, cexsrc)
    @test rule.ruleid == RuleUrn("nouninfl.h_hs2") 
    @test rule.inflectionclass == "h_hs"
    @test rule.ending == "ης"
    @test rule.ngender == "feminine"
    @test rule.ncase == "genitive"
    @test rule.nnumber == GMPNumber(1)
end


@testset "Read stems for noun tokens from delimited text"  begin    
    cexsrc = "nounstems.n22502|lexent.n22502|γνωμ|feminine|h_hs|recessive|"
    nounsio = Kanones.NounIO("nouns")
    stem = Kanones.readstemrow(nounsio, cexsrc)
    @test  stem.stemid == StemUrn("nounstems.n22502")
    @test stem.lexid == LexemeUrn("lexent.n22502")
    @test stem.form == "γνωμ"
    @test stem.gender == "feminine"
    @test stem.inflectionclass == "h_hs"
    @test stem.accentpersistence == "recessive"
end


@testset "Read stems for irregular noun tokens from delimited text" begin
    cexsrc = "irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun"
    irregnounio = Kanones.IrregularNounIO("irregular nouns")
    stem = Kanones.readstemrow(irregnounio, cexsrc)

    @test  stem.stemid  == StemUrn("irregnoun.irregn23069a") 
    @test stem.lexid == LexemeUrn("lsj.n23069") 
    @test stem.form == nfkc("γυνή")
    @test stem.noungender == "feminine"
    @test stem.nouncase == "nominative"
    @test stem.nounnumber ==  GMPNumber(1)
end

