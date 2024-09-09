var documenterSearchIndex = {"docs":
[{"location":"apis/apis/#API-documentation","page":"Julia API documentation","title":"API documentation","text":"","category":"section"},{"location":"apis/apis/","page":"Julia API documentation","title":"Julia API documentation","text":"code\nformurn","category":"page"},{"location":"apis/apis/#Kanones.code","page":"Julia API documentation","title":"Kanones.code","text":"Integer code for a tense value.\n\ncode(tense)\n\n\n\n\n\n\nInteger code for a mood property.\n\ncode(mood)\n\n\n\n\n\n\nInteger code for a voice property.\n\ncode(voice)\n\n\n\n\n\n\nInteger code for a person property.\n\ncode(person)\n\n\n\n\n\n\nInteger code for number property.\n\ncode(num)\n\n\n\n\n\n\nInteger code for a gender property.\n\ncode(gender)\n\n\n\n\n\n\nFind integer code for a case object.\n\ncode(mcase)\n\n\n\n\n\n\nInteger code for a degree object.\n\ncode(degree)\n\n\n\n\n\n\nInteger code for an uninflected property.\n\ncode(utype)\n\n\n\n\n\n\nCompose a digital code for adj.\n\ncode(verb)\n\n\n\n\n\n\nCompose a digital code string for the form identified in rule.\n\ncode(rule)\n\n\n\n\n\n\nCompose a digital code string for the form identified in verb.\n\ncode(verb)\n\n\n\n\n\n\nCompose a digital code string for the form identified in inf.\n\ncode(p)\n\n\n\n\n\n\nCompose a digital code for inf.\n\ncode(inf)\n\n\n\n\n\n\nCompose digital code for morphological form identified in rule.\n\ncode(rule)\n\n\n\n\n\n\nCompose a digital code string for the form identified in inf.\n\ncode(inf)\n\n\n\n\n\n\nCompose digital code for ptcpl.\n\ncode(ptcpl)\n\n\n\n\n\n\nCompose string of digits for form in rule.\n\ncode(rule)\n\n\n\n\n\n\nCompose a digital code for vadj.\n\ncode(vadj)\n\n\n\n\n\n\nCompose a digital code for noun.\n\ncode(noun)\n\n\n\n\n\n\nCompose a digital code string for the form identified in rule.\n\ncode(rule)\n\n\n\n\n\n\nCompose a digital code string for the form identified in noun.\n\ncode(noun)\n\n\n\n\n\n\nCompose a digital code for adj.\n\ncode(adj)\n\n\n\n\n\n\nCompose digital code for morphological form identified in rule.\n\ncode(rule)\n\n\n\n\n\n\nCompose a digital code string for the form identified in adj.\n\ncode(adj)\n\n\n\n\n\n\nCompose a digital code for adv.\n\ncode(adv)\n\n\n\n\n\n\nCompose a digital code for pronoun.\n\ncode(pronoun)\n\n\n\n\n\n\nCompose a digital code string for the form identified in pns.\n\ncode(pns)\n\n\n\n\n\n\nCompose digital code for uform.\n\ncode(uform)\n\n\n\n\n\n\nCompose a digital code string for the form identified in uninfl.\n\ncode(uninfl)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/apis/#Kanones.formurn","page":"Julia API documentation","title":"Kanones.formurn","text":"Compose an abbreviated URN for a rule from a IrregularRule.\n\nformurn(irreg)\n\n\n\n\n\n\nCompose a FormUrn for a GMFFiniteVerb.\n\nformurn(verbform)\n\n\n\n\n\n\nCompose an abbreviated URN for a rule from a FiniteVerbRule.\n\nformurn(rule)\n\n\n\n\n\n\nCompose an abbreviated URN for a rule from a IrregularAdjectiveStem.\n\nformurn(verb)\n\n\n\n\n\n\nCompose an abbreviated URN for a rule from a IrregularAdjectiveStem.\n\nformurn(p)\n\n\n\n\n\n\nCompose a FormUrn for an GMFInfinitive.\n\nformurn(infinitive)\n\n\n\n\n\n\nCompose an abbreviated URN for a rule from an InfinitiveRule.\n\nformurn(rule)\n\n\n\n\n\n\nCompose an abbreviated URN for a rule from a IrregularAdjectiveStem.\n\nformurn(inf)\n\n\n\n\n\n\nCompose a FormUrn for an GMFParticiple.\n\nformurn(ptcpl)\n\n\n\n\n\n\nCompose an abbreviated URN for a rule from an InfinitiveRule.\n\nformurn(rule)\n\n\n\n\n\n\nCompose a FormUrn for an GMFVerbalAdjective.\n\nformurn(vadj)\n\n\n\n\n\n\nCompose an abbreviated URN for a rule from a VerbalAdjectiveRule.\n\nformurn(rule)\n\n\n\n\n\n\nCompose a FormUrn for a GMFNoun.\n\nformurn(noun)\n\n\n\n\n\n\nCompose an abbreviated URN for a rule from a NounRule.\n\nformurn(rule)\n\n\n\n\n\n\nCompose an abbreviated URN for a rule from a IrregularNounStem.\n\nformurn(noun)\n\n\n\n\n\n\nCompose a FormUrn for an GMFAdjective.\n\nformurn(adj)\n\n\n\n\n\n\nCompose an abbreviated URN for a morphological form identified in rule.\n\nformurn(rule)\n\n\n\n\n\n\nCompose an abbreviated URN for a rule from a IrregularAdjectiveStem.\n\nformurn(adj)\n\n\n\n\n\n\nCompose a FormUrn for an GMFAdjective.\n\nformurn(adv)\n\n\n\n\n\n\nCompose a FormUrn for a GMFPronoun.\n\nformurn(pronoun)\n\n\n\n\n\n\nCompose an abbreviated URN for a rule from a PronounStem.\n\nformurn(pns)\n\n\n\n\n\n\nCompose a FormUrn for an GMFUninflected.\n\nformurn(uninflected)\n\n\n\n\n\n\nCompose an abbreviated URN for a rule from a UninflectedStem.\n\nformurn(uninfl)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/apis/#Parsing","page":"Julia API documentation","title":"Parsing","text":"","category":"section"},{"location":"apis/apis/","page":"Julia API documentation","title":"Julia API documentation","text":"generate\ndecline","category":"page"},{"location":"apis/apis/#CitableParserBuilder.generate","page":"Julia API documentation","title":"CitableParserBuilder.generate","text":"Catch failure to implement generate function for a subtype of CitableParser.\n\ngenerate(lex, mform, p)\n\n\n\n\n\n\nGenerate all possible morphological analyses for a given lexeme and form.\n\ngenerate(lex, mform, parser; delim)\n\n\n\n\n\n\nGenerate all possible morphological analyses for a given lexeme and form.\n\ngenerate(lex, mform, parser)\n\n\n\n\n\n\nGenerate a form for a given stem and rule.\n\ngenerate(stem, rule; ortho)\n\n\n\n\n\n\nGenerate the correct string for lex in the form form.\n\ngenerate(lex, form, ruleset, stemset, orthography)\n\n\n\n\n\n\nGenerate a form for a given lexeme and form within a given dataset.\n\ngenerate(lex, form, kds)\n\n\n\n\n\n\nGenerate a form for a given noun stem and rule by combining stem and ending, then adding appropriate accent for this lexical item in this form, and finally stripping off metadata characters marking vowel quantity and morpheme boundaries.\n\ngenerate(stem, rule; ortho)\n\n\n\n\n\n\nGenerate a form for a given adjective stem and rule by combining stem and ending, then adding appropriate accent for this lexical item in this form, and finally stripping off metadata characters marking vowel quantity and morpheme boundaries.\n\ngenerate(stem, rule; ortho)\n\n\n\n\n\n\nGenerate a form for a given noun stem and rule by combining stem and ending, then adding appropriate accent for this lexical item in this form, and finally stripping off metadata characters marking vowel quantity and morpheme boundaries.\n\ngenerate(stem, rule; ortho)\n\n\n\n\n\n\nGenerate a form for a given adjective stem and rule by combining stem and ending, then adding appropriate accent for this lexical item in this form, and finally stripping off metadata characters marking vowel quantity and morpheme boundaries.\n\ngenerate(stem, rule; ortho)\n\n\n\n\n\n\nGenerate a form for a given noun stem and rule by combining stem and ending, then adding appropriate accent for this lexical item in this form, and finally stripping off metadata characters marking vowel quantity and morpheme boundaries.\n\ngenerate(stem, rule; ortho)\n\n\n\n\n\n\nGenerate a form for a given adjective stem and rule by combining stem and ending, then adding appropriate accent for this lexical item in this form, and finally stripping off metadata characters marking vowel quantity and morpheme boundaries.\n\ngenerate(stem, rule; ortho)\n\n\n\n\n\n\nGenerate a form for a given pronoun stem and rule by combining stem and ending, then adding appropriate accent for this lexical item in this form, and finally stripping off metadata characters marking vowel quantity and morpheme boundaries.\n\ngenerate(stem, rule; ortho)\n\n\n\n\n\n\nGenerate a form for a given noun stem and rule by combining stem and ending, then adding appropriate accent for this lexical item in this form, and finally stripping off metadata characters marking vowel quantity and morpheme boundaries.\n\ngenerate(stem, rule; ortho)\n\n\n\n\n\n\nGenerate a form for a given noun stem and rule by combining stem and ending, then adding appropriate accent for this lexical item in this form, and finally stripping off metadata characters marking vowel quantity and morpheme boundaries.\n\ngenerate(stem, rule; ortho)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/apis/#Kanones.decline","page":"Julia API documentation","title":"Kanones.decline","text":"Decline all case-number combinations of lex, a noun.\n\ndecline(lex, sp; withvocative)\n\n\n\n\n\n\nDecline all case-number combinations of lex, a noun.\n\ndecline(lex, kd; withvocative)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#APIs:-morphological-properties-and-forms","page":"Morphological properties and forms","title":"APIs: morphological properties and forms","text":"","category":"section"},{"location":"apis/morph/#Properties","page":"Morphological properties and forms","title":"Properties","text":"","category":"section"},{"location":"apis/morph/","page":"Morphological properties and forms","title":"Morphological properties and forms","text":"Retrieve morphological properties:","category":"page"},{"location":"apis/morph/","page":"Morphological properties and forms","title":"Morphological properties and forms","text":"gmpGender\ngmpCase\ngmpNumber\ngmpPerson\ngmpTense\ngmpMood\ngmpVoice\ngmpDegree\ngmpUninflectedType","category":"page"},{"location":"apis/morph/#Kanones.gmpGender","page":"Morphological properties and forms","title":"Kanones.gmpGender","text":"Extract gender property from a KanonesRule.\n\ngmpGender(stem)\n\n\n\n\n\n\nFind gender of a form.\n\ngmpGender(gmf)\n\n\n\n\n\n\nConstruct gender property from a string value.\n\ngmpGender(s)\n\n\n\n\n\n\nConstruct gender property from an integer code.\n\ngmpGender(code)\n\n\n\n\n\n\nIdentify gender of ptcpl.\n\ngmpGender(ptcpl)\n\n\n\n\n\n\nExtract gender property from p.\n\ngmpGender(p)\n\n\n\n\n\n\nIdentify gender property of rule.\n\ngmpGender(rule)\n\n\n\n\n\n\nExtract gender property from vadj.\n\ngmpGender(vadj)\n\n\n\n\n\n\nExtract gender from n.\n\ngmpGender(n)\n\n\n\n\n\n\nIdentify gender property for nr.\n\ngmpGender(nr)\n\n\n\n\n\n\nIdentify gender of ns.\n\ngmpGender(ns)\n\n\n\n\n\n\nIdentify gender of noun.\n\ngmpGender(noun)\n\n\n\n\n\n\nExtract gender from adj.\n\ngmpGender(adj)\n\n\n\n\n\n\nIdentify gender for adj.\n\ngmpGender(adj)\n\n\n\n\n\n\nIdentify gender of adj.\n\ngmpGender(adj)\n\n\n\n\n\n\nExtract gender property from p.\n\ngmpGender(p)\n\n\n\n\n\n\nIdentify gender of pr.\n\ngmpGender(pr)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpCase","page":"Morphological properties and forms","title":"Kanones.gmpCase","text":"Extract case property from a KanonesRule.\n\ngmpCase(rule)\n\n\n\n\n\n\nFind case of a form.\n\ngmpCase(gmf)\n\n\n\n\n\n\nConstruct a case from a string value.\n\ngmpCase(s)\n\n\n\n\n\n\nConstruct a case from an integer code.\n\ngmpCase(code)\n\n\n\n\n\n\nIdentify case of ptcpl.\n\ngmpCase(ptcpl)\n\n\n\n\n\n\nExtract case property from p.\n\ngmpCase(p)\n\n\n\n\n\n\nIdentify case property of rule.\n\ngmpCase(rule)\n\n\n\n\n\n\nExtract case property from vadj.\n\ngmpCase(vadj)\n\n\n\n\n\n\nExtract case from n.\n\ngmpCase(n)\n\n\n\n\n\n\nIdentify case property for nr.\n\ngmpCase(nr)\n\n\n\n\n\n\nIdentify case of noun.\n\ngmpCase(noun)\n\n\n\n\n\n\nExtract case from adj.\n\ngmpCase(adj)\n\n\n\n\n\n\nIdentify case for adj.\n\ngmpCase(adj)\n\n\n\n\n\n\nIdentify case of adj.\n\ngmpCase(adj)\n\n\n\n\n\n\nExtract case property from p.\n\ngmpCase(p)\n\n\n\n\n\n\nIdentify case of pr.\n\ngmpCase(pr)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpNumber","page":"Morphological properties and forms","title":"Kanones.gmpNumber","text":"Extract number property from a KanonesRule.\n\ngmpNumber(rule)\n\n\n\n\n\n\nFind number of a form.\n\ngmpNumber(gmf)\n\n\n\n\n\n\nConstruct a number property from a string value.\n\ngmpNumber(s)\n\n\n\n\n\n\nConstruct a number property from an integer code.\n\ngmpNumber(code)\n\n\n\n\n\n\nExtract number property from v.\n\ngmpNumber(v)\n\n\n\n\n\n\nFind number property for rule.\n\ngmpNumber(rule)\n\n\n\n\n\n\nIdentify tense of verb.\n\ngmpNumber(verb)\n\n\n\n\n\n\nIdentify number of ptcpl.\n\ngmpNumber(ptcpl)\n\n\n\n\n\n\nExtract tense property from p.\n\ngmpNumber(p)\n\n\n\n\n\n\nIdentify number property of rule.\n\ngmpNumber(rule)\n\n\n\n\n\n\nExtract number property from vadj.\n\ngmpNumber(vadj)\n\n\n\n\n\n\nExtract number from n.\n\ngmpNumber(n)\n\n\n\n\n\n\nIdentify number property for nr.\n\ngmpNumber(nr)\n\n\n\n\n\n\nIdentify number of noun.\n\ngmpNumber(noun)\n\n\n\n\n\n\nExtract number from adj.\n\ngmpNumber(adj)\n\n\n\n\n\n\nIdentify number for adj.\n\ngmpNumber(adj)\n\n\n\n\n\n\nIdentify number of adj.\n\ngmpNumber(adj)\n\n\n\n\n\n\nExtract number property from p.\n\ngmpNumber(p)\n\n\n\n\n\n\nIdentify number of pr.\n\ngmpNumber(pr)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpPerson","page":"Morphological properties and forms","title":"Kanones.gmpPerson","text":"Extract person property from a KanonesRule.\n\ngmpPerson(rule)\n\n\n\n\n\n\nFind person of a form.\n\ngmpPerson(gmf)\n\n\n\n\n\n\nConstruct a person property from a string value.\n\ngmpPerson(s)\n\n\n\n\n\n\nConstruct a person property from an integer code.\n\ngmpPerson(code)\n\n\n\n\n\n\nExtract person property from v.\n\ngmpPerson(v)\n\n\n\n\n\n\nFind person property for rule.\n\ngmpPerson(rule)\n\n\n\n\n\n\nIdentify person of verb.\n\ngmpPerson(verb)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpTense","page":"Morphological properties and forms","title":"Kanones.gmpTense","text":"Extract tense property from a KanonesRule.\n\ngmpTense(rule)\n\n\n\n\n\n\nFind tense of a form.\n\ngmpTense(gmf)\n\n\n\n\n\n\nConstruct tense property from a string value.\n\ngmpTense(s)\n\n\n\n\n\n\nConstruct tense property from an integer code.\n\ngmpTense(code)\n\n\n\n\n\n\nExtract tense property from v.\n\ngmpTense(v)\n\n\n\n\n\n\nFind tense property for rule.\n\ngmpTense(rule)\n\n\n\n\n\n\nIdentify tense of verb.\n\ngmpTense(verb)\n\n\n\n\n\n\nIdentify tense of ptcpl.\n\ngmpTense(ptcpl)\n\n\n\n\n\n\nExtract tense value from inf.\n\ngmpTense(inf)\n\n\n\n\n\n\nFind tense property of inf.\n\ngmpTense(inf)\n\n\n\n\n\n\nIdentify tense of inf.\n\ngmpTense(inf)\n\n\n\n\n\n\nExtract tense property from p.\n\ngmpTense(p)\n\n\n\n\n\n\nIdentify tense property of rule.\n\ngmpTense(rule)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpMood","page":"Morphological properties and forms","title":"Kanones.gmpMood","text":"Extract mood property from a KanonesRule.\n\ngmpMood(rule)\n\n\n\n\n\n\nFind mood of a form.\n\ngmpMood(gmf)\n\n\n\n\n\n\nConstruct mood property from a string value.\n\ngmpMood(s)\n\n\n\n\n\n\nConstruct mood property from an integer code.\n\ngmpMood(code)\n\n\n\n\n\n\nExtract mood property from v.\n\ngmpMood(v)\n\n\n\n\n\n\nFind mood property for rule.\n\ngmpMood(rule)\n\n\n\n\n\n\nIdentify mood of verb.\n\ngmpMood(verb)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpVoice","page":"Morphological properties and forms","title":"Kanones.gmpVoice","text":"Extract voice property from a KanonesRule.\n\ngmpVoice(rule)\n\n\n\n\n\n\nFind voice of a form.\n\ngmpVoice(gmf)\n\n\n\n\n\n\nConstruct a voice property from a string value.\n\ngmpVoice(s)\n\n\n\n\n\n\nConstruct a voice property from an integer code.\n\ngmpVoice(code)\n\n\n\n\n\n\nExtract voice property from v.\n\ngmpVoice(v)\n\n\n\n\n\n\nFind voice property for rule.\n\ngmpVoice(rule)\n\n\n\n\n\n\nIdentify voice of verb.\n\ngmpVoice(verb)\n\n\n\n\n\n\nIdentify voice of ptcpl.\n\ngmpVoice(ptcpl)\n\n\n\n\n\n\nExtract voice value from inf.\n\ngmpVoice(inf)\n\n\n\n\n\n\nFind voice property of inf.\n\ngmpVoice(inf)\n\n\n\n\n\n\nIdentify voice of inf.\n\ngmpVoice(inf)\n\n\n\n\n\n\nExtract voice property from p.\n\ngmpVoice(p)\n\n\n\n\n\n\nIdentify voice property of rule.\n\ngmpVoice(rule)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpDegree","page":"Morphological properties and forms","title":"Kanones.gmpDegree","text":"Extract degree property from a KanonesRule.\n\ngmpDegree(rule)\n\n\n\n\n\n\nFind degree of a form.\n\ngmpDegree(gmf)\n\n\n\n\n\n\nConstruct degree from a string value.\n\ngmpDegree(s)\n\n\n\n\n\n\nConstruct degree from an integer code.\n\ngmpDegree(code)\n\n\n\n\n\n\nExtract degree from adj.\n\ngmpDegree(adj)\n\n\n\n\n\n\nIdentify degree for adj.\n\ngmpDegree(adj)\n\n\n\n\n\n\nIdentify degree of adj.\n\ngmpDegree(adj)\n\n\n\n\n\n\nRetrieve degree property of adv.\n\ngmpDegree(adv)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpUninflectedType","page":"Morphological properties and forms","title":"Kanones.gmpUninflectedType","text":"Find part of speech of an uninflected form.\n\ngmpUninflectedType(gmf)\n\n\n\n\n\n\nConstruct an uninflected property from a string value.\n\ngmpUninflectedType(s)\n\n\n\n\n\n\nConstruct an uninflected property from an integer code.\n\ngmpUninflectedType(code)\n\n\n\n\n\n\nExtract \"part of speech\" type from uform.\n\ngmpUninflectedType(uform)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Forms","page":"Morphological properties and forms","title":"Forms","text":"","category":"section"},{"location":"apis/morph/","page":"Morphological properties and forms","title":"Morphological properties and forms","text":"Construct morphological forms:","category":"page"},{"location":"apis/morph/","page":"Morphological properties and forms","title":"Morphological properties and forms","text":"gmfAdjective\ngmfAdverb\ngmfFiniteVerb\ngmfInfinitive\ngmfNoun\ngmfParticiple\ngmfPronoun\ngmfUninflected\ngmfVerbalAdjective","category":"page"},{"location":"apis/morph/#Kanones.gmfAdjective","page":"Morphological properties and forms","title":"Kanones.gmfAdjective","text":"Create an GMFAdjective from a string value.\n\ngmfAdjective(code)\n\n\n\n\n\n\nCreate an GMFAdjective from a CITE2 URN.\n\ngmfAdjective(urn)\n\n\n\n\n\n\nCreate a GMFAdjective from a FormUrn.\n\ngmfAdjective(f)\n\n\n\n\n\n\nCreate a GMFAdjective from an Analysis.\n\ngmfAdjective(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfAdverb","page":"Morphological properties and forms","title":"Kanones.gmfAdverb","text":"Construct a GMFAdverb from a digital code.\n\ngmfAdverb(code)\n\n\n\n\n\n\nConstruct a GMFAdverb from a FormUrn.\n\ngmfAdverb(abbrurn)\n\n\n\n\n\n\nConstruct a GMFAdverb from a Cite2Urn.\n\ngmfAdverb(urn)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfFiniteVerb","page":"Morphological properties and forms","title":"Kanones.gmfFiniteVerb","text":"Create a GMFFiniteVerb from a string value.\n\ngmfFiniteVerb(code)\n\n\n\n\n\n\nCreate a GMFFiniteVerb from a Cite2URN.\n\ngmfFiniteVerb(urn)\n\n\n\n\n\n\nCreate a GMFFiniteVerb from a FormUrn.\n\ngmfFiniteVerb(f)\n\n\n\n\n\n\nCreate a GMFFiniteVerb from an Analysis.\n\ngmfFiniteVerb(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfInfinitive","page":"Morphological properties and forms","title":"Kanones.gmfInfinitive","text":"Create an GMFInfinitive from a string value.\n\ngmfInfinitive(code)\n\n\n\n\n\n\nCreate an GMFInfinitive from a Cite2Urn.\n\ngmfInfinitive(urn)\n\n\n\n\n\n\nCreate an GMFInfinitive from a FormUrn.\n\ngmfInfinitive(f)\n\n\n\n\n\n\nCreate an GMFInfinitive from an Analysis.\n\ngmfInfinitive(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfNoun","page":"Morphological properties and forms","title":"Kanones.gmfNoun","text":"Create a GMFNoun from a string value.\n\ngmfNoun(code)\n\n\n\n\n\n\nCreate a GMFNoun from a Cite2Urn.\n\ngmfNoun(urn)\n\n\n\n\n\n\nCreate a GMFNoun from a FormUrn.\n\ngmfNoun(f)\n\n\n\n\n\n\nCreate a GMFNoun from an Analysis.\n\ngmfNoun(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfParticiple","page":"Morphological properties and forms","title":"Kanones.gmfParticiple","text":"Create a GMFParticiple from a string value.\n\ngmfParticiple(code)\n\n\n\n\n\n\nCreate a GMFParticiple from a Cite2Urn.\n\ngmfParticiple(urn)\n\n\n\n\n\n\nCreate a GMFParticiple from a FormUrn.\n\ngmfParticiple(f)\n\n\n\n\n\n\nCreate a GMFParticiple from an Analysis.\n\ngmfParticiple(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfPronoun","page":"Morphological properties and forms","title":"Kanones.gmfPronoun","text":"Create a GMFPronoun from a string value.\n\ngmfPronoun(code)\n\n\n\n\n\n\nCreate a GMFPronoun from a Cite2Urn.\n\ngmfPronoun(urn)\n\n\n\n\n\n\nCreate a GMFPronoun from a FormUrn.\n\ngmfPronoun(f)\n\n\n\n\n\n\nCreate a GMFPronoun from an Analysis.\n\ngmfPronoun(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfUninflected","page":"Morphological properties and forms","title":"Kanones.gmfUninflected","text":"Create GMFUninflected from a Cite2Urn.\n\ngmfUninflected(urn)\n\n\n\n\n\n\nCreate GMFUninflected from a FormUrn.\n\ngmfUninflected(u)\n\n\n\n\n\n\nCreate GMFUninflected from a string value.\n\ngmfUninflected(codeString)\n\n\n\n\n\n\nCreate GMFUninflected from a Char.\n\ngmfUninflected(ch)\n\n\n\n\n\n\nCreate GMFUninflected from an Int.\n\ngmfUninflected(code)\n\n\n\n\n\n\nCreate GMFUninflected from an Analysis.\n\ngmfUninflected(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfVerbalAdjective","page":"Morphological properties and forms","title":"Kanones.gmfVerbalAdjective","text":"Create a GMFVerbalAdjective from a string value.\n\ngmfVerbalAdjective(code)\n\n\n\n\n\n\nCreate a GMFVerbalAdjective from a Cite2Urn.\n\ngmfVerbalAdjective(urn)\n\n\n\n\n\n\nCreate a GMFVerbalAdjective from a FormUrn.\n\ngmfVerbalAdjective(f)\n\n\n\n\n\n\nCreate a GMFVerbalAdjective from an Analysis.\n\ngmfVerbalAdjective(a)\n\n\n\n\n\n\n","category":"function"},{"location":"#Kanones.jl","page":"The Kanones system for building morphological parsers","title":"Kanones.jl","text":"","category":"section"},{"location":"","page":"The Kanones system for building morphological parsers","title":"The Kanones system for building morphological parsers","text":"User's guide and documentation are available from https://neelsmith.quarto.pub/kanones/.","category":"page"},{"location":"","page":"The Kanones system for building morphological parsers","title":"The Kanones system for building morphological parsers","text":"API docs generated with Documenter are available here.","category":"page"}]
}
