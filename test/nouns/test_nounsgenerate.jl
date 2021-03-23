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