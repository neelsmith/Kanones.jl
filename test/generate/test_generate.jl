@testset "Test generating forms from stem+rule" begin
    nounio = Kanones.NounIO("IO for nouns")
    nounstemsrc = "nounstems.n8909|lsj.n8909|ἀνθρωπ|masculine|os_ou|recessive|"
    nounstem = Kanones.readstemrow(nounio, nounstemsrc)
    nounrulesrc = "nouninfl.os_ou1|os_ou|ος|masculine|nominative|singular|"
    nounrule = Kanones.readrulerow(nounio, nounrulesrc)
    @test generate(nounstem, nounrule) == "ἄνθρωπος"


    adjio = Kanones.AdjectiveIO("IO for adjs")
    adjstemsrc = "adjstems.n52332|lsj.n52332|κακ|os_h_on_pos|inflectionaccented|"
    adjstem = Kanones.readstemrow(adjio, adjstemsrc)
    adjrulesrc = "adjinfl.osaon1|os_a_on|ος|masculine|nominative|singular|positive|"
    adjrule = Kanones.readrulerow(adjio, adjrulesrc)
    @test generate(adjstem, adjrule) == "κακός"

    verbio = Kanones.VerbIO("IO for verbs")
    verbsrc = "verbinfl.numipres8|numi|νυσαι|second|singular|present|indicative|middle|"
    verbrule = Kanones.readrulerow(verbio, verbsrc)
    verbstemsrc = "verbstems.n23658|lsj.n23658|δεικ|numi"
    verbstem = Kanones.readstemrow(verbio, verbstemsrc)
    @test  generate(verbstem,verbrule) == "δείκνυσαι"

end