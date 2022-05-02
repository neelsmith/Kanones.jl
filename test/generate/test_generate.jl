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

    pronio = Kanones.PronounIO("prons")
    pronrulesrc = "proninfl.pronouns1|article"
    pronrule = Kanones.readrulerow(pronio, pronrulesrc)
    pronstemsrc = "pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article" 
    pronstem = Kanones.readstemrow(pronio, pronstemsrc)
    @test generate(pronstem, pronrule) == "ὁ"
    





    verbio = Kanones.VerbIO("IO for verbs")
    verbsrc = "verbinfl.numipres8|numi|νυσαι|second|singular|present|indicative|middle|"
    verbrule = Kanones.readrulerow(verbio, verbsrc)
    verbstemsrc = "verbstems.n23658|lsj.n23658|δεικ|numi"
    verbstem = Kanones.readstemrow(verbio, verbstemsrc)
    @test  generate(verbstem,verbrule) == "δείκνυσαι"


    vadjio = Kanones.VerbalAdjectiveIO("adjectives")
    vadjrulesrc = "vadjinfl.numi1|numi|τέον|neuter|nominative|singular|"
    vadjrule = Kanones.readrulerow(vadjio, vadjrulesrc)
    @test generate(verbstem, vadjrule) == "δεικτέον"

    ptcplio = Kanones.ParticipleIO("ptcpls")
    ptcplsrc = "ptcplinfl.wpres1|numi|νυόμενος|present|middle|masculine|nominative|singular|"
    ptcplrule = Kanones.readrulerow(ptcplio, ptcplsrc)
    @test generate(verbstem, ptcplrule) == "δεικνυόμενος"

    infio = Kanones.InfinitiveIO("infs")
    infsrc = "infinfl.wreg1|numi|νύειν|present|active"
    infrule = Kanones.readrulerow(infio, infsrc)
    @test generate(verbstem, infrule) == "δεικνύειν"



    uninflio = Kanones.UninflectedIO("IO for uninfls")
    uninflstemsrc = "uninflectedstems.n51951|lsj.n51951|καί|conjunction|"
    uninflstem = Kanones.readstemrow(uninflio, uninflstemsrc)
    uninflrulesrc = "uninfl.uninfl2|conjunction"
    uninflrule = Kanones.readrulerow(uninflio, uninflrulesrc)

    @test generate(uninflstem, uninflrule) == "καί"



    irregruleio = Kanones.IrregularRuleParser("IO for irregular rules")
    irregnounrulesrc = "irreginfl.irregular1|irregularnoun"
    irrnounrule = Kanones.readrulerow(irregruleio, irregnounrulesrc)

    irrnounio = Kanones.IrregularNounIO("IO for irreg nouns")
    irregnounstemsrc = "irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun"
    irrnounstem = Kanones.readstemrow(irrnounio, irregnounstemsrc)
    @test generate(irrnounstem, irrnounrule) == "γυνή"

    
    irregadjrulesrc = "irreginfl.irregular4|irregularadjective"
    irradjrule = Kanones.readrulerow(irregruleio, irregadjrulesrc)

    irradjstemio = Kanones.IrregularAdjectiveIO("IO for irreg adj stems")
    irradjstemsrc = "irregadj.n79904a|lsj.n79904|πᾶς|masculine|nominative|singular|positive|irregularadjective"
    irradjstem = Kanones.readstemrow(irradjstemio, irradjstemsrc)
    @test generate(irradjstem, irradjrule) == "πᾶς"
    

    irrinfsrc = "irreginfl.irregular3|irregularinfinitive"
    irrinfrule = Kanones.readrulerow(irregruleio, irrinfsrc)

    irrinfstemio = Kanones.IrregularInfinitiveIO("IO for irreg infinivite stems")
    irrinfstemsrc = "irreginf.irreginfln31130|lsj.n31130|εἶναι|present|active|irregularinfinitive"
    irrinfstem = Kanones.readstemrow(irrinfstemio, irrinfstemsrc)
    @test generate(irrinfstem, irrinfrule) == "εἶναι"
end