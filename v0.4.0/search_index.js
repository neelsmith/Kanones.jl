var documenterSearchIndex = {"docs":
[{"location":"lexicon/#Lexicon","page":"Vocabulary items","title":"Lexicon","text":"","category":"section"},{"location":"lexicon/","page":"Vocabulary items","title":"Vocabulary items","text":"Special relationship between database of lexemes and LSJ lexicon:","category":"page"},{"location":"lexicon/","page":"Vocabulary items","title":"Vocabulary items","text":"ids coordinated\nKanones manages two collections: manually confirmed entries, and automatically inferred entries.  See LSJMining.jl.","category":"page"},{"location":"lexicon/","page":"Vocabulary items","title":"Vocabulary items","text":"Free to add other items in their own collection.","category":"page"},{"location":"utilities/#Utilities","page":"Utilities","title":"Utilities","text":"","category":"section"},{"location":"utilities/","page":"Utilities","title":"Utilities","text":"repo = pwd() |> dirname |> dirname","category":"page"},{"location":"utilities/#Set-up","page":"Utilities","title":"Set up","text":"","category":"section"},{"location":"utilities/","page":"Utilities","title":"Utilities","text":"Start by loading a Kanones dataset.  We'll use the lg-core data in the datasets subdirectory of the Kanones github repository.","category":"page"},{"location":"utilities/","page":"Utilities","title":"Utilities","text":"using Kanones\nsourcedata = joinpath(repo, \"datasets\", \"lg-core\")\nkdata = dataset([sourcedata])\nkdata isa Kanones.Dataset","category":"page"},{"location":"utilities/#Decline-a-noun","page":"Utilities","title":"Decline a noun","text":"","category":"section"},{"location":"utilities/","page":"Utilities","title":"Utilities","text":"Decline a noun that you have identified with its LexemeUrn.","category":"page"},{"location":"utilities/","page":"Utilities","title":"Utilities","text":"using CitableParserBuilder\nανθρωπος = LexemeUrn(\"lsj.n8909\")\ndecline(ανθρωπος, kdata)","category":"page"},{"location":"stemtypes/nouns/decl1/#First-declension-nouns","page":"Regular nouns: first declension","title":"First-declension nouns","text":"","category":"section"},{"location":"forms/#Morphological-forms","page":"Morphological forms","title":"Morphological forms","text":"","category":"section"},{"location":"forms/","page":"Morphological forms","title":"Morphological forms","text":"Form types are subtypes of GreekMorphologicalForm, and are defined by a group of morphological properties.","category":"page"},{"location":"forms/#Substantives","page":"Morphological forms","title":"Substantives","text":"","category":"section"},{"location":"forms/","page":"Morphological forms","title":"Morphological forms","text":"There are three types of substantive form.  They are instantiated from three rule types and three stem types.","category":"page"},{"location":"forms/","page":"Morphological forms","title":"Morphological forms","text":"GMFNoun: has GMPGender, GMPCase, GMPNumber.  Note that gender is inherent (see user's guide on stem records)","category":"page"},{"location":"forms/","page":"Morphological forms","title":"Morphological forms","text":"GMFPronoun: has GMPGender, GMPCase, GMPNumber but in contrast to GMFNoun, gender can vary.","category":"page"},{"location":"forms/","page":"Morphological forms","title":"Morphological forms","text":"GMFAdjective: has GMPGender, GMPCase, GMPNumber and GMPDegree.","category":"page"},{"location":"forms/#Adverbs","page":"Morphological forms","title":"Adverbs","text":"","category":"section"},{"location":"forms/","page":"Morphological forms","title":"Morphological forms","text":"GMFAdverb has GMPDegree.  Distinct rule type combined with stems for adjective.","category":"page"},{"location":"forms/#Verbal-forms","page":"Morphological forms","title":"Verbal forms","text":"","category":"section"},{"location":"forms/","page":"Morphological forms","title":"Morphological forms","text":"Verb stems combine with distinct rule types for:","category":"page"},{"location":"forms/","page":"Morphological forms","title":"Morphological forms","text":"GMFFiniteVerb: GMPPerson, GMPNumber, GMPTense, GMPMood, GMPVoice","category":"page"},{"location":"forms/","page":"Morphological forms","title":"Morphological forms","text":"GMFInfinitive:  GMPTense, GMPVoice","category":"page"},{"location":"forms/","page":"Morphological forms","title":"Morphological forms","text":"GMFParticiple:  GMPTense, GMPVoice, GMPGender, GMPCase, GMPNumber","category":"page"},{"location":"forms/","page":"Morphological forms","title":"Morphological forms","text":"GMFVerbalAdjecive: GMPGender, GMPCase, GMPNumber; no degree; unlike nouns and pronouns, derived from a verbal stem.","category":"page"},{"location":"forms/#Uninflected-forms","page":"Morphological forms","title":"Uninflected forms","text":"","category":"section"},{"location":"forms/","page":"Morphological forms","title":"Morphological forms","text":"GMFUninflected have GMPUninflectedType.  Distinct rule type and stem type.","category":"page"},{"location":"forms/","page":"Morphological forms","title":"Morphological forms","text":"note: TBA: CEX collection of all possible forms\nA future version of Kanones will include a delimited-text source for the full collection of possible morphological forms recognized by Kanones.","category":"page"},{"location":"stemtypes/#Reference:-Stem-types-and-paradigms","page":"Contents","title":"Reference: Stem types and paradigms","text":"","category":"section"},{"location":"bg/#Background:-analysis-by-synthesis","page":"Background","title":"Background: analysis by synthesis","text":"","category":"section"},{"location":"bg/","page":"Background","title":"Background","text":"note: Morphological analysis (parsing)\nGiven a token (a string value), generate pairings of a vocabulary item (lexeme) and a morphological form.","category":"page"},{"location":"bg/","page":"Background","title":"Background","text":"Symmetrical operation: synthesis.  Given a form and a lexeme, generate surface token.","category":"page"},{"location":"bg/","page":"Background","title":"Background","text":"Normally assumed that analysis and synthesis are reversible.","category":"page"},{"location":"bg/","page":"Background","title":"Background","text":"This is not true in Greek. Interaction of morphological systems, phonological systems, and movable accent are not stateless.","category":"page"},{"location":"bg/#Kanones'-solution","page":"Background","title":"Kanones' solution","text":"","category":"section"},{"location":"bg/","page":"Background","title":"Background","text":"Generate all possible forms\n\"Parsing\" becomes a lookup operation\nA \"parser\" becomes the set of all possible tokens associated with all possible analyses for that token","category":"page"},{"location":"bg/","page":"Background","title":"Background","text":"Result in 2022: technologically minimal and fast for use; easily implemented from plain-text data sources that a classicist can modify or add to.","category":"page"},{"location":"bg/#Analysis","page":"Background","title":"Analysis","text":"","category":"section"},{"location":"bg/","page":"Background","title":"Background","text":"Kanones uses model of CitableParserBuilder module","category":"page"},{"location":"bg/","page":"Background","title":"Background","text":"four components:\nlexeme\nform\nstem\nrule\nall elements other than string tokens identified by URN","category":"page"},{"location":"urns/#Identification-with-URNs","page":"Identification with URNs","title":"Identification with URNs","text":"","category":"section"},{"location":"urns/","page":"Identification with URNs","title":"Identification with URNs","text":"URNs used in four elements of analysis are Cite2Urns\nKanones works with abbreviated form\nexpansion of abbreviated form to full URNs is managed throug a URN registry","category":"page"},{"location":"stemtypes/nouns/decl3/#Third-declension-nouns","page":"Regular nouns: third declension","title":"Third-declension nouns","text":"","category":"section"},{"location":"stemtypes/nouns/decl2/#Second-declension-nouns","page":"Regular nouns: second declension","title":"Second-declension nouns","text":"","category":"section"},{"location":"stemtypes/nouns/decl2/","page":"Regular nouns: second declension","title":"Regular nouns: second declension","text":"Stem entries:","category":"page"},{"location":"stemtypes/nouns/decl2/","page":"Regular nouns: second declension","title":"Regular nouns: second declension","text":"StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|\nnounstems.n29828|lsj.n29828|δωρ|neuter|os_ou|recessive|\nnounstems.n8909|lsj.n8909|ἀνθρωπ|masculine|os_ou|recessive|","category":"page"},{"location":"stemtypes/nouns/decl2/","page":"Regular nouns: second declension","title":"Regular nouns: second declension","text":"Paradigms generated from these entries:","category":"page"},{"location":"stemtypes/nouns/decl2/","page":"Regular nouns: second declension","title":"Regular nouns: second declension","text":"using Kanones, CitableParserBuilder, Markdown\nrepo = pwd() |> dirname |> dirname |> dirname |> dirname\nsrcdir = joinpath(repo, \"datasets\", \"lg-core\") \nkds = Kanones.dataset([srcdir])\nανθρωπος = LexemeUrn(\"lsj.n8909\")\n\n\nMarkdown.parse(mddeclension(ανθρωπος, kds))","category":"page"},{"location":"stemtypes/nouns/decl2/","page":"Regular nouns: second declension","title":"Regular nouns: second declension","text":"using Kanones, CitableParserBuilder, Markdown\nrepo = pwd() |> dirname |> dirname |> dirname |> dirname\nsrcdir = joinpath(repo, \"datasets\", \"lg-core\") \nkds = Kanones.dataset([srcdir])\nδωρον = LexemeUrn(\"lsj.n29828\")\n\n\nMarkdown.parse(mddeclension(δωρον, kds))","category":"page"},{"location":"stems/#Stems","page":"Lexical stems","title":"Stems","text":"","category":"section"},{"location":"stems/","page":"Lexical stems","title":"Lexical stems","text":"Stems associate a string and an inflectional class with a lexeme, identified by URN value\nSome types of stem require further information that pertains to the stem (e.g., inherent gender or persistent accent pattern)","category":"page"},{"location":"stems/#Example","page":"Lexical stems","title":"Example","text":"","category":"section"},{"location":"apis/apis/#API-documentation","page":"Julia API documentation","title":"API documentation","text":"","category":"section"},{"location":"apis/apis/","page":"Julia API documentation","title":"Julia API documentation","text":"code\nformurn","category":"page"},{"location":"apis/apis/#Kanones.code","page":"Julia API documentation","title":"Kanones.code","text":"Compose a digital code for adj.\n\ncode(verb)\n\n\n\n\n\n\nCompose a digital code for inf.\n\ncode(inf)\n\n\n\n\n\n\nCompose digital code for ptcpl.\n\ncode(ptcpl)\n\n\n\n\n\n\nCompose a digital code for vadj.\n\ncode(vadj)\n\n\n\n\n\n\nCompose a digital code for noun.\n\ncode(noun)\n\n\n\n\n\n\nCompose a digital code string for the form identified in rule.\n\ncode(rule)\n\n\n\n\n\n\nCompose a digital code for adj.\n\ncode(adj)\n\n\n\n\n\n\nCompose digital code for morphological form identified in rule.\n\ncode(rule)\n\n\n\n\n\n\nCompose a digital code for adv.\n\ncode(adv)\n\n\n\n\n\n\nCompose a digital code for pronoun.\n\ncode(pronoun)\n\n\n\n\n\n\nCompose digital code for uform.\n\ncode(uform)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/apis/#Kanones.formurn","page":"Julia API documentation","title":"Kanones.formurn","text":"Compose a FormUrn for a GMFFiniteVerb.\n\nformurn(verbform)\n\n\n\n\n\n\nCompose a FormUrn for an GMFInfinitive.\n\nformurn(infinitive)\n\n\n\n\n\n\nCompose a FormUrn for an GMFParticiple.\n\nformurn(ptcpl)\n\n\n\n\n\n\nCompose a FormUrn for an GMFVerbalAdjective.\n\nformurn(vadj)\n\n\n\n\n\n\nCompose a FormUrn for a GMFNoun.\n\nformurn(noun)\n\n\n\n\n\n\nCompose an abbreviated URN for a rule from a NounRule.\n\nformurn(rule)\n\n\n\n\n\n\nCompose a FormUrn for an GMFAdjective.\n\nformurn(adj)\n\n\n\n\n\n\nCompose an abbreviated URN for a morphological form identified in rule.\n\nformurn(rule)\n\n\n\n\n\n\nCompose a FormUrn for an GMFAdjective.\n\nformurn(adv)\n\n\n\n\n\n\nCompose a FormUrn for a GMFPronoun.\n\nformurn(pronoun)\n\n\n\n\n\n\nCompose a FormUrn for an GMFUninflected.\n\nformurn(uninflected)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/apis/#Parsing","page":"Julia API documentation","title":"Parsing","text":"","category":"section"},{"location":"apis/apis/","page":"Julia API documentation","title":"Julia API documentation","text":"generate\ndecline","category":"page"},{"location":"apis/apis/#Kanones.generate","page":"Julia API documentation","title":"Kanones.generate","text":"Generate a form for a given stem and rule.\n\ngenerate(stem, rule; ortho)\n\n\n\n\n\n\nGenerate a form for a given noun stem and rule by combining stem and ending, then adding appropriate accent for this lexical item in this form, and finally stripping off metadata characters marking vowel quantity and morpheme boundaries.\n\ngenerate(stem, rule; ortho)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/apis/#Kanones.decline","page":"Julia API documentation","title":"Kanones.decline","text":"Decline all case-number combinations of lex, a noun.\n\ndecline(lex, kd; withvocative)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#APIs:-morphological-properties-and-forms","page":"Morphological properties and forms","title":"APIs: morphological properties and forms","text":"","category":"section"},{"location":"apis/morph/#Properties","page":"Morphological properties and forms","title":"Properties","text":"","category":"section"},{"location":"apis/morph/","page":"Morphological properties and forms","title":"Morphological properties and forms","text":"Retrieve morphological properties:","category":"page"},{"location":"apis/morph/","page":"Morphological properties and forms","title":"Morphological properties and forms","text":"gmpGender\ngmpCase\ngmpNumber\ngmpPerson\ngmpTense\ngmpMood\ngmpVoice\ngmpDegree\ngmpUninflectedType","category":"page"},{"location":"apis/morph/#Kanones.gmpGender","page":"Morphological properties and forms","title":"Kanones.gmpGender","text":"Extract gender property from a KanonesRule.\n\n\n\n\n\nFind gender of a form.\n\ngmpGender(gmf)\n\n\n\n\n\n\nExtract gender property from p.\n\ngmpGender(p)\n\n\n\n\n\n\nExtract gender property from vadj.\n\ngmpGender(vadj)\n\n\n\n\n\n\nExtract gender from n.\n\ngmpGender(n)\n\n\n\n\n\n\nIdentify gender property for nr.\n\ngmpGender(nr)\n\n\n\n\n\n\nIdentify gender of ns.\n\ngmpGender(ns)\n\n\n\n\n\n\nExtract gender from adj.\n\ngmpGender(adj)\n\n\n\n\n\n\nExtract gender property from p.\n\ngmpGender(p)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpCase","page":"Morphological properties and forms","title":"Kanones.gmpCase","text":"Extract case property from a KanonesRule.\n\n\n\n\n\nFind case of a form.\n\n\n\n\n\nExtract case property from p.\n\ngmpCase(p)\n\n\n\n\n\n\nExtract case property from vadj.\n\ngmpCase(vadj)\n\n\n\n\n\n\nExtract case from n.\n\ngmpCase(n)\n\n\n\n\n\n\nIdentify case property for nr.\n\ngmpCase(nr)\n\n\n\n\n\n\nExtract case from adj.\n\ngmpCase(adj)\n\n\n\n\n\n\nExtract case property from p.\n\ngmpCase(p)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpNumber","page":"Morphological properties and forms","title":"Kanones.gmpNumber","text":"Extract number property from a KanonesRule.\n\n\n\n\n\nFind number of a form.\n\n\n\n\n\nExtract number property from v.\n\ngmpNumber(v)\n\n\n\n\n\n\nExtract tense property from p.\n\ngmpNumber(p)\n\n\n\n\n\n\nExtract number property from vadj.\n\ngmpNumber(vadj)\n\n\n\n\n\n\nExtract number from n.\n\ngmpNumber(n)\n\n\n\n\n\n\nIdentify number property for nr.\n\ngmpNumber(nr)\n\n\n\n\n\n\nExtract number from adj.\n\ngmpNumber(adj)\n\n\n\n\n\n\nExtract number property from p.\n\ngmpNumber(p)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpPerson","page":"Morphological properties and forms","title":"Kanones.gmpPerson","text":"Extract person property from a KanonesRule.\n\n\n\n\n\nFind person of a form.\n\n\n\n\n\nExtract person property from v.\n\ngmpPerson(v)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpTense","page":"Morphological properties and forms","title":"Kanones.gmpTense","text":"Extract tense property from a KanonesRule.\n\n\n\n\n\nFind tense of a form.\n\n\n\n\n\nExtract tense property from v.\n\ngmpTense(v)\n\n\n\n\n\n\nExtract tense value from inf.\n\ngmpTense(inf)\n\n\n\n\n\n\nExtract tense property from p.\n\ngmpTense(p)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpMood","page":"Morphological properties and forms","title":"Kanones.gmpMood","text":"Extract mood property from a KanonesRule.\n\n\n\n\n\nFind mood of a form.\n\n\n\n\n\nExtract mood property from v.\n\ngmpMood(v)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpVoice","page":"Morphological properties and forms","title":"Kanones.gmpVoice","text":"Extract voice property from a KanonesRule.\n\n\n\n\n\nFind voice of a form.\n\n\n\n\n\nExtract voice property from v.\n\ngmpVoice(v)\n\n\n\n\n\n\nExtract voice value from inf.\n\ngmpVoice(inf)\n\n\n\n\n\n\nExtract voice property from p.\n\ngmpVoice(p)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpDegree","page":"Morphological properties and forms","title":"Kanones.gmpDegree","text":"Extract degree property from a KanonesRule.\n\n\n\n\n\nFind degree of a form.\n\n\n\n\n\nExtract degree from adj.\n\ngmpDegree(adj)\n\n\n\n\n\n\nRetrieve degree property of adv.\n\ngmpDegree(adv)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmpUninflectedType","page":"Morphological properties and forms","title":"Kanones.gmpUninflectedType","text":"Find part of speech of an uninflected form.\n\n\n\n\n\nExtract \"part of speech\" type from uform.\n\ngmpUninflectedType(uform)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Forms","page":"Morphological properties and forms","title":"Forms","text":"","category":"section"},{"location":"apis/morph/","page":"Morphological properties and forms","title":"Morphological properties and forms","text":"Construct morphological forms:","category":"page"},{"location":"apis/morph/","page":"Morphological properties and forms","title":"Morphological properties and forms","text":"gmfAdjective\ngmfAdverb\ngmfFiniteVerb\ngmfInfinitive\ngmfNoun\ngmfParticiple\ngmfPronoun\ngmfUninflected\ngmfVerbalAdjective","category":"page"},{"location":"apis/morph/#Kanones.gmfAdjective","page":"Morphological properties and forms","title":"Kanones.gmfAdjective","text":"Create an GMFAdjective from a string value.\n\ngmfAdjective(code)\n\n\n\n\n\n\nCreate an GMFAdjective from a CITE2 URN.\n\ngmfAdjective(urn)\n\n\n\n\n\n\nCreate a GMFAdjective from a FormUrn.\n\ngmfAdjective(f)\n\n\n\n\n\n\nCreate a GMFAdjective from an Analysis.\n\ngmfAdjective(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfAdverb","page":"Morphological properties and forms","title":"Kanones.gmfAdverb","text":"Construct a GMFAdverb from a digital code.\n\ngmfAdverb(code)\n\n\n\n\n\n\nConstruct a GMFAdverb from a FormUrn.\n\ngmfAdverb(abbrurn)\n\n\n\n\n\n\nConstruct a GMFAdverb from a Cite2Urn.\n\ngmfAdverb(urn)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfFiniteVerb","page":"Morphological properties and forms","title":"Kanones.gmfFiniteVerb","text":"Create a GMFFiniteVerb from a string value.\n\ngmfFiniteVerb(code)\n\n\n\n\n\n\nCreate a GMFFiniteVerb from a Cite2URN.\n\ngmfFiniteVerb(urn)\n\n\n\n\n\n\nCreate a GMFFiniteVerb from a FormUrn.\n\ngmfFiniteVerb(f)\n\n\n\n\n\n\nCreate a GMFFiniteVerb from an Analysis.\n\ngmfFiniteVerb(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfInfinitive","page":"Morphological properties and forms","title":"Kanones.gmfInfinitive","text":"Create an GMFInfinitive from a string value.\n\ngmfInfinitive(code)\n\n\n\n\n\n\nCreate an GMFInfinitive from a Cite2Urn.\n\ngmfInfinitive(urn)\n\n\n\n\n\n\nCreate an GMFInfinitive from a FormUrn.\n\ngmfInfinitive(f)\n\n\n\n\n\n\nCreate an GMFInfinitive from an Analysis.\n\ngmfInfinitive(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfNoun","page":"Morphological properties and forms","title":"Kanones.gmfNoun","text":"Create a GMFNoun from a string value.\n\ngmfNoun(code)\n\n\n\n\n\n\nCreate a GMFNoun from a Cite2Urn.\n\ngmfNoun(urn)\n\n\n\n\n\n\nCreate a GMFNoun from a FormUrn.\n\ngmfNoun(f)\n\n\n\n\n\n\nCreate a GMFNoun from an Analysis.\n\ngmfNoun(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfParticiple","page":"Morphological properties and forms","title":"Kanones.gmfParticiple","text":"Create a GMFParticiple from a string value.\n\ngmfParticiple(code)\n\n\n\n\n\n\nCreate a GMFParticiple from a Cite2Urn.\n\ngmfParticiple(urn)\n\n\n\n\n\n\nCreate a GMFParticiple from a FormUrn.\n\ngmfParticiple(f)\n\n\n\n\n\n\nCreate a GMFParticiple from an Analysis.\n\ngmfParticiple(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfPronoun","page":"Morphological properties and forms","title":"Kanones.gmfPronoun","text":"Create a GMFPronoun from a string value.\n\ngmfPronoun(code)\n\n\n\n\n\n\nCreate a GMFPronoun from a Cite2Urn.\n\ngmfPronoun(urn)\n\n\n\n\n\n\nCreate a GMFPronoun from a FormUrn.\n\ngmfPronoun(f)\n\n\n\n\n\n\nCreate a GMFPronoun from an Analysis.\n\ngmfPronoun(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfUninflected","page":"Morphological properties and forms","title":"Kanones.gmfUninflected","text":"Create GMFUninflected from a Cite2Urn.\n\ngmfUninflected(urn)\n\n\n\n\n\n\nCreate GMFUninflected from a FormUrn.\n\ngmfUninflected(u)\n\n\n\n\n\n\nCreate GMFUninflected from a string value.\n\ngmfUninflected(codeString)\n\n\n\n\n\n\nCreate GMFUninflected from a Char.\n\ngmfUninflected(ch)\n\n\n\n\n\n\nCreate GMFUninflected from an Int.\n\ngmfUninflected(code)\n\n\n\n\n\n\nCreate GMFUninflected from an Analysis.\n\ngmfUninflected(a)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/morph/#Kanones.gmfVerbalAdjective","page":"Morphological properties and forms","title":"Kanones.gmfVerbalAdjective","text":"Create a GMFVerbalAdjective from a string value.\n\ngmfVerbalAdjective(code)\n\n\n\n\n\n\nCreate a GMFVerbalAdjective from a Cite2Urn.\n\ngmfVerbalAdjective(urn)\n\n\n\n\n\n\nCreate a GMFVerbalAdjective from a FormUrn.\n\ngmfVerbalAdjective(f)\n\n\n\n\n\n\nCreate a GMFVerbalAdjective from an Analysis.\n\ngmfVerbalAdjective(a)\n\n\n\n\n\n\n","category":"function"},{"location":"properties/#Morphological-properties","page":"Morphological properties","title":"Morphological properties","text":"","category":"section"},{"location":"properties/#Overview","page":"Morphological properties","title":"Overview","text":"","category":"section"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"Of the four data sets Kanones uses (vocabulary, forms, stems and rules), only one is not editable: forms.  The set of possible forms defines a morphology as \"Greek\".","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"Morphological forms (next page) are defined by unique sets of the morphological properties (that is, subtypes of GreekMorphologicalProperty) listed here.","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"using Kanones\nperson = GMPPerson(3)","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"All properties work with the label and code functions.`","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"label(person)","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"code(person)","category":"page"},{"location":"properties/#Properties","page":"Morphological properties","title":"Properties","text":"","category":"section"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"The full set of properties is: person, number, tense, mood, voice, gender, case, degree and uninflected part of speech.","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"Properties may be constructed directly from numeric codes, or from the string value returned by its label function by using an  constructor function with identical name to the type but with initial lowercase gmp.","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"Person: three values labelled first, second, third.","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"gmpPerson(3) == gmpPerson(\"third\")","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"Number: three values labelled singular, dual, plural.","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"gmpNumber(3) == gmpNumber(\"plural\")","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"Tense: six values labelled present, imperfect, aorist, perfect, pluperfect and future.","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"gmpTense(3) == gmpTense(\"aorist\")","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"Mood: four values labelled indicative, subjunctive, optative, imperative.","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"gmpMood(1) == gmpMood(\"indicative\")","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"Voice: three values labelled active, middle, passive.","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"gmpVoice(2) == gmpVoice(\"middle\")","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"Gender: three values labelled masculine, feminine, neuter.","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"gmpGender(2) == gmpGender(\"feminine\")","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"Case: five values labelled nominative, genitive, dative, accusative, vocative.","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"gmpCase(2) == gmpCase(\"genitive\")","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"Degree: three values labelled positive, comparative, superlative.","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"gmpDegree(2) == gmpDegree(\"comparative\")","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"Uninflected part of speech: six values labelled conjunction,     preposition, particle, adverb, numeral, interjection","category":"page"},{"location":"properties/","page":"Morphological properties","title":"Morphological properties","text":"gmpUninflectedType(2) == gmpUninflectedType(\"preposition\")","category":"page"},{"location":"stemtypes/nouns/#Noun-paradigms-and-inflectional-classes","page":"Nouns","title":"Noun paradigms and inflectional classes","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"repo = pwd() |> dirname |> dirname ","category":"page"},{"location":"#Kanones","page":"Home","title":"Kanones","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"☛ Build customized morphological parsers for ancient Greek","category":"page"},{"location":"","page":"Home","title":"Home","text":"all data managed in delimited-text tables you can modify or add to with any text editor\nrigorously defined orthography.  Example parsers include standard orthography of printed editions of literary Greek, and a parser for epigraphic Greek in the alphabet used by Athens before 403 BCE.\nimplemented entirely in the Julia language (no other technical prerequisites): \nplatform independent\nfast\ncode library can be used from command line, in scripts, in web apps, directly in an editor like Visual Studio Code","category":"page"},{"location":"#Quick-example:-interactive-building-and-parsing","page":"Home","title":"Quick example: interactive building and parsing","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Load a dataset, and build a parser from it.","category":"page"},{"location":"","page":"Home","title":"Home","text":"using Kanones, CitableParserBuilder, Markdown\nsrcdir = joinpath(repo, \"datasets\", \"lg-core\") \nkds = Kanones.dataset([srcdir])\np = stringParser(kds)\np isa StringParser","category":"page"},{"location":"","page":"Home","title":"Home","text":"Parse a string: there's are two results in this case.","category":"page"},{"location":"","page":"Home","title":"Home","text":"s = \"ἀνθρώπῳ\"\nparses = parsetoken(s, p)\nlength(parses)","category":"page"},{"location":"","page":"Home","title":"Home","text":"Label the results:","category":"page"},{"location":"","page":"Home","title":"Home","text":"parses .|> gmfNoun .|> label","category":"page"},{"location":"#Contents","page":"Home","title":"Contents","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Background: a synthesis-first approach to parsing NL morphology\nUser's guide:  the four datasets Kanones uses\nReference: stem classes and paradigms\nReference: API documentation","category":"page"},{"location":"rules/#Inflectional-rules","page":"Inflectional rules","title":"Inflectional rules","text":"","category":"section"},{"location":"rules/","page":"Inflectional rules","title":"Inflectional rules","text":"associate an ending and an inflectional class with a morphological form\nin managing rules from delimited-text files, different types of morphological forms are represented by appropriate property values\nrules can be read from delimited-text source with readrulerow","category":"page"},{"location":"rules/#Example","page":"Inflectional rules","title":"Example","text":"","category":"section"},{"location":"rules/","page":"Inflectional rules","title":"Inflectional rules","text":"Read a rule from delimited text:","category":"page"},{"location":"rules/","page":"Inflectional rules","title":"Inflectional rules","text":"using Kanones\ndelimited = \"adjinfl.osaon1|os_a_on|ος|masculine|nominative|singular|positive|\"\nadjio = Kanones.AdjectiveIO(\"adjectives\")\nrule = Kanones.readrulerow(adjio, delimited)","category":"page"},{"location":"rules/","page":"Inflectional rules","title":"Inflectional rules","text":"Find its RuleUrn:","category":"page"},{"location":"rules/","page":"Inflectional rules","title":"Inflectional rules","text":"ruleurn(rule)","category":"page"},{"location":"rules/","page":"Inflectional rules","title":"Inflectional rules","text":"Find its inflectional type and inflectional ending:","category":"page"},{"location":"rules/","page":"Inflectional rules","title":"Inflectional rules","text":"inflectionClass(rule)","category":"page"},{"location":"rules/","page":"Inflectional rules","title":"Inflectional rules","text":"ending(rule)","category":"page"},{"location":"rules/#morphological-data","page":"Inflectional rules","title":"morphological data","text":"","category":"section"},{"location":"rules/","page":"Inflectional rules","title":"Inflectional rules","text":"formabbr = formurn(rule) expectedabbr = FormUrn(\"forms.7010001110\") @test formabbr == expectedabbr","category":"page"},{"location":"rules/","page":"Inflectional rules","title":"Inflectional rules","text":"formcode = code(rule) expectedcode = \"7010001110\" @test formcode == expectedcode","category":"page"}]
}
