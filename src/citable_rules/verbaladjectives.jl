
"""Compose an abbreviated URN for a rule from a `NounRule`.

$(SIGNATURES)
"""
function ruleurn(rule::VerbalAdjectiveRule)
    numdict = labeldict(numberpairs)
    casedict = labeldict(casepairs)
    genderdict = labeldict(genderpairs)

    # PosPNTMVGCDCat
    RuleUrn(string("morphforms.", VERBALADJECTIVE,"0",numdict[rule.vanumber],"000",genderdict[rule.vagender],casedict[rule.vacase],"00"))
end
