@testset "Read rules for noun tokens from delimited text" begin
    cex = "nouninfl.h_hs2|h_hs|ης|feminine|genitive|singular|"
    nounparser = FstBuilder.NounParser("nouns")
    rulerow = FstBuilder.readrulerow(nounparser, cex)
    #@test rulerow.infltype == "conjunction"
    #expectedrule = Kanones.RuleUrn("litgreek.indeclinable2")
    #@test rulerow.ruleid.collection == "litgreek"
    #@test rulerow.ruleid.objectid == "indeclinable2"
end


@testset "Write fst rules for noun tokens" begin
end


@testset "Read stems for noun tokens from delimited text"  begin    
end

@testset "Write fst lexicon for noun stems" begin
end



@testset "Build parser and parse noun forms" begin
    #=
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset(repo * "/datasets/synoptic/")
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")
    
    parser = d * "/testcompile/greek.a"
    =#
    #analyzed = parsetoken(parser, "και")
    #println(analyzed)
end