@testset "Test creating a specified principal part for a stem" begin
    verbio = Kanones.VerbIO("IO for verbs")
    stemsrc = "verbstems.n56496|lsj.n56496|κελευ|w_regular|"
    stem = Kanones.readstemrow(verbio, stemsrc)

    @test Kanones.sigmabase(stem) == "κελευσ"
    @test Kanones.kappabase(stem) == "κελευκ"

end


@testset "Test creating principal part for rule+stem combo" begin
    verbio = Kanones.VerbIO("IO for verbs")
    stemsrc = "verbstems.n56496|lsj.n56496|κελευ|w_regular|"
    stem = Kanones.readstemrow(verbio, stemsrc)



    pp1rulesrc = "verbinfl.wregrpindic1|w_regular|ω|first|singular|present|indicative|active"
    pp1rule = Kanones.readrulerow(verbio, pp1rulesrc)
    @test Kanones.takesaugment(greekForm(pp1rule)) == false
    @test Kanones.takesreduplication(greekForm(pp1rule), inflectionclass(pp1rule)) == false
    @test Kanones.ppbase(stem,pp1rule) == "κελευ"
    @test generate(stem, pp1rule) == "κελεύω"

    pp2rulesrc = "verbinfl.wregfut1|w_regular|ω|first|singular|future|indicative|active"
    pp2rule = Kanones.readrulerow(verbio, pp2rulesrc)
    
    @test Kanones.pp2(pp2rule)
    @test Kanones.takesaugment(greekForm(pp2rule)) == false
    @test Kanones.takesreduplication(greekForm(pp2rule), inflectionclass(pp2rule)) == false
    @test Kanones.ppbase(stem,pp2rule) == "κελευσ"

    @test generate(stem, pp2rule) == "κελεύσω"
end