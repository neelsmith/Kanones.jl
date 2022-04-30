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


    vadjio = Kanones.VerbalAdjectiveIO("adjectives")
    vadjrulesrc = "vadjinfl.wreg1|w_regular|τέον|neuter|nominative|singular|"
    vadjrule = Kanones.readrulerow(vadjio, vadjrulesrc)
    @test generate(verbstem, vadjrule) == "δεικτέον"

    ptcplio = Kanones.ParticipleIO("ptcpls")
    ptcplsrc = "ptcplinfl.wpres1|w_regular|όμενος|present|middle|masculine|nominative|singular|"
    ptcplrule = Kanones.readrulerow(ptcplio, ptcplsrc)
    @test_broken generate(verbstem, ptcplrule) == "δεικνυόμενος"

    infio = Kanones.InfinitiveIO("infs")
    infsrc = "infinfl.wreg1|w_regular|ειν|present|active"
    infrule = Kanones.readrulerow(infio, infsrc)
    @test_broken generate(verbstem, infrule) == "δεικνύειν"

    pronio = Kanones.PronounIO("prons")
    pronrulesrc = "proninfl.pronouns1|article"
    pronrule = Kanones.readrulerow(pronio, pronrulesrc)
    pronstemsrc = "pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article" 
    pronstem = Kanones.readstemrow(pronio, pronstemsrc)
    @test generate(pronstem, pronrule) == "ὁ"
    
end