@testset "Test generating forms from stem+rule" begin
    nounstemsrc = "nounstems.n8909|lsj.n8909|ἀνθρωπ|masculine|os_ou|recessive|"
    nounstem = fromcex(nounstemsrc, NounStem)
    nounrulesrc = "nouninfl.os_ou1|os_ou|ος|masculine|nominative|singular|"
    nounrule = fromcex(nounrulesrc, NounRule)
    @test generate(nounstem, nounrule) == knormal("ἄνθρωπος")


    adjstemsrc = "adjstems.n52332|lsj.n52332|κακ|os_h_on_pos|inflectionaccented|"
    adjstem = fromcex(adjstemsrc, AdjectiveStem)
    adjrulesrc = "adjinfl.osaon1|os_a_on|ος|masculine|nominative|singular|positive|"
    adjrule = fromcex(adjrulesrc, AdjectiveRule)
    @test generate(adjstem, adjrule) == knormal("κακός")

    pronrulesrc = "proninfl.pronouns1|article"
    pronrule = fromcex(pronrulesrc, PronounRule)
    pronstemsrc = "pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article" 
    pronstem = fromcex(pronstemsrc, PronounStem)
    @test generate(pronstem, pronrule) == knormal("ὁ")
    

    verbsrc = "verbinfl.numipres8|numi|νυσαι|second|singular|present|indicative|middle|"
    verbrule = fromcex(verbsrc, FiniteVerbRule)
    verbstemsrc = "verbstems.n23658|lsj.n23658|δεικ|numi|"
    verbstem = fromcex(verbstemsrc, VerbStem)
    @test  generate(verbstem,verbrule) == knormal("δείκνυσαι")


    
    
    vadjrulesrc = "vadjinfl.numi1|numi|τέον|neuter|nominative|singular|"
    vadjrule = fromcex(vadjrulesrc, VerbalAdjectiveRule)
    @test generate(verbstem, vadjrule) == knormal("δεικτέον")

    ptcplsrc = "ptcplinfl.wpres1|numi|νυόμενος|present|middle|masculine|nominative|singular|"
    ptcplrule = fromcex(ptcplsrc, ParticipleRule)
    @test generate(verbstem, ptcplrule) == knormal("δεικνυόμενος")

    infsrc = "infinfl.wreg1|numi|νύειν|present|active"
    infrule = fromcex(infsrc, InfinitiveRule)
    @test generate(verbstem, infrule) == knormal("δεικνύειν")


    uninflstemsrc = "uninflectedstems.n51951|lsj.n51951|καί|conjunction|"
    uninflstem = fromcex(uninflstemsrc, UninflectedStem)
    uninflrulesrc = "uninfl.uninfl2|conjunction"
    uninflrule = fromcex(uninflrulesrc, UninflectedRule)

    @test generate(uninflstem, uninflrule) == knormal("καί")

    
    
    irregnounrulesrc = "irreginfl.irregular1|irregularnoun"
    irrnounrule = fromcex(irregnounrulesrc, IrregularRule)

    
    irregnounstemsrc = "irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun"
    irrnounstem = fromcex(irregnounstemsrc, IrregularNounStem)
    @test generate(irrnounstem, irrnounrule) == knormal("γυνή")

    irregadjrulesrc = "irreginfl.irregular4|irregularadjective"
    irradjrule = fromcex(irregadjrulesrc, IrregularRule)

    
    irradjstemsrc = "irregadj.n79904a|lsj.n79904|πᾶς|masculine|nominative|singular|positive|irregularadjective"
    irradjstem = fromcex(irradjstemsrc, IrregularAdjectiveStem)
    @test generate(irradjstem, irradjrule) == knormal("πᾶς")

    irrinfsrc = "irreginfl.irregular3|irregularinfinitive"
    irrinfrule = fromcex(irrinfsrc, IrregularRule)

    irrinfstemsrc = "irreginf.irreginfln31130|lsj.n31130|εἶναι|present|active|irregularinfinitive"
    irrinfstem = fromcex(irrinfstemsrc, IrregularInfinitiveStem)
    @test generate(irrinfstem, irrinfrule) == knormal("εἶναι")

    irrverbsrc = "irreginfl.irregular2|irregularfiniteverb"
    irrverbrule = fromcex(irrverbsrc, IrregularRule)

    irrverbstemsrc = "irregverb.irregverbn31130a1|lsj.n31130|ἐστι|third|singular|present|indicative|active|irregularfiniteverb"
    irrverbstem = fromcex(irrverbstemsrc, IrregularVerbStem)

    @test generate(irrverbstem, irrverbrule) == knormal("ἐστι")
    
end