@testset "Read rules for noun tokens from delimited text" begin
    cex = "nouninfl.h_hs2|h_hs|ης|feminine|genitive|singular|recessive"
    nounparser = Kanones.NounParser("nouns")
    rulerow = Kanones.readrulerow(nounparser, cex)
    
    @test rulerow.inflectionclass == "h_hs"
    #expectedrule = Kanones.RuleUrn("litgreek.indeclinable2")
    #@test rulerow.ruleid.collection == "litgreek"
    #@test rulerow.ruleid.objectid == "indeclinable2"
end


@testset "Write fst rules for noun tokens" begin
    cex = "nouninfl.h_hs2|h_hs|ης|feminine|genitive|singular|recessive"
    nounparser = Kanones.NounParser("nouns")
    rulerow = Kanones.readrulerow(nounparser, cex)
    
    FstBuilder.fst(rulerow)
end


@testset "Read stems for noun tokens from delimited text"  begin    
    cex = "nounstems.n22502|lexent.n22502|γνωμ|masculine|h_hs|recessive|"
    nounparser = Kanones.NounParser("nouns")
    stemrow = Kanones.readstemrow(nounparser, cex)
end

@testset "Write fst lexicon for noun stems" begin
    cex = "nounstems.n22502|lexent.n22502|γνωμ|masculine|h_hs|recessive|"
    nounparser = Kanones.NounParser("nouns")
    stemrow = Kanones.readstemrow(nounparser, cex)

    FstBuilder.fst(stemrow)
end



@testset "Build parser and parse noun forms" begin
    
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset(repo * "/datasets/synoptic/")
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")
    
    parser = d * "/testcompile/greek.a"
    
    ##analyzed = parsetoken(parser, "γνωμαις")
    #println(analyzed)
    #FstBuilder.applyparser(parser, stripped)
end