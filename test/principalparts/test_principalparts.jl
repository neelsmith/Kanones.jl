@testset "Test creating a specified principal part for a stem" begin
    verbio = Kanones.VerbIO("IO for verbs")
    stemsrc = "verbstems.n56496|lsj.n56496|κελευ|w_regular|"
    stem = Kanones.readstemrow(verbio, stemsrc)

    @test Kanones.sigmabase(stem) == "κελευσ"
    @test Kanones.kappabase(stem) == "κελευκ"

end


@testset "Test creating principal part for rule+stem combo" begin
    verbio = Kanones.VerbIO("IO for verbs")

    rulesrc = "verbinfl.wregfut1|w_regular|ω|first|singular|future|indicative|active"
    stemsrc = "verbstems.n56496|lsj.n56496|κελευ|w_regular|"
    rule = Kanones.readrulerow(verbio, rulesrc)
    stem = Kanones.readstemrow(verbio, stemsrc)

    @test Kanones.pp2(rule)
    @test Kanones.takesaugment(greekForm(rule)) == false
    @test Kanones.takesreduplication(greekForm(rule)) == false
    @test Kanones.ppbase(stem,rule) == "κελευσ"

    @test generate(stem, rule) == "κελεύσω"
end