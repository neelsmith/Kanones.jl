@testset ExtendedTestSet "Read rules for verbal adjective tokens from delimited text" begin
    cexsrc = "vadjinfl.econtr1|ew_contract|ητέον|neuter|nominative|singular|"
    vadjparser = Kanones.VerbalAdjectiveIO("verbal adjective")
    rule = Kanones.readrulerow(vadjparser, cexsrc)
    rule.ruleid |> string == "vadjinfl.econtr1"

    @test rule.inflectionclass == "ew_contract"
    @test rule.ending == "ητέον"
    @test rule.vagender == GMPGender(3)
    @test rule.vacase == GMPCase(1)
    @test rule.vanumber == GMPNumber(1)
end

# No stems to test:  use stems for finite verbs.
# Ergo also no irregular stems to test.