@testset "Format fst rules for verbal adjective forms" begin
    cexsrc = "vadjinfl.econtr1|ew_contract|ητέον|neuter|nominative|singular|"
    vadjparser = Kanones.VerbalAdjectiveRuleParser("verbal adjective")
    rule = Kanones.readrulerow(vadjparser, cexsrc)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    expected = "<ew_contract><verbaladjective>ητεον<neuter><nominative><singular><u>vadjinfl\\.econtr1</u>"
    @test FstBuilder.fst(rule) == expected
end

# No regular or irregular stems for verbal adjectives:
# use stems for finite verbs.