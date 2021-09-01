
"""Compose `acceptor.fst` and write to file `target`.

$(SIGNATURES)
"""
function buildacceptor(target)
    fstroot = dirname(target)
    incl = string("#include \"", fstroot, "/symbols.fst\"")

    squashers = join([
        irregularsquasher(),
        uninflsquasher(),
        nounsquasher(),
        finiteverbsquasher(),
        infinitivesquasher(),
        participlesquasher(),
        verbaladjectivesquasher(),
        adjectivesquasher(),
        pronounsquasher()

    ], "\n")
    squasherunion = join([
        "% Union of all URN squashers:",
        raw"$acceptor$ = $squashuninflurn$ | $squashnounurn$ | $squashirregurn$ | $squashverburn$ | $squashinfinitiveurn$ | $squashparticipleurn$ | $squashverbaladjectiveurn$ | $squashadjectiveurn$ | $squashpronounurn$ "
    ], "\n")
    stripper = join([
        "%% Put all symbols in 2 categories:  pass",
        "%% surface symbols through, suppress analytical symbols.",
        raw"#analysissymbol# = #editorial# #urntag# #uninflected# #pos# #morphtag# #stemtype#  #separator#",
        raw"#surfacesymbol# = #letter#",
        raw"ALPHABET = [#surfacesymbol#] [#analysissymbol#]:<>",
        raw"$stripsym$ = .+"
    ],"\n")
    closing = join([
        "%% The canonical pipeline: (morph data) -> acceptor -> parser/stripper"
        raw"$acceptor$ || $stripsym$"
    ],"\n")

    doc = join([incl,squashers,squasherunion,stripper,closing], "\n\n")
    open(target, "w") do io
        print(io, doc)
    end
end

"""Compose transducer for filtering nouns.

$(SIGNATURES)
"""
function nounsquasher()
    join([
    "% Noun acceptor:",
    raw"$=nounclass$ = [#nounclass#]",
    raw"$=gender$ = [#gender#]",
    raw"$squashnounurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<noun>$=gender$ $=nounclass$   <div> $=nounclass$  <noun> [#stemchars#]* $=gender$ $case$ $number$ <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>"

    ], "\n")
end

"""Compose transducer for filtering uninflected forms.

$(SIGNATURES)"""
function uninflsquasher()
    join([
        "% Uninflected form acceptor:",
        raw"$=uninflectedclass$ = [#uninflected#]",
        raw"$squashuninflurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> [#stemchars#]+ <uninflected> $=uninflectedclass$ <div>   $=uninflectedclass$ <uninflected><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>"
    ], "\n")
end




"""Compose transducer for filtering irregular forms.

$(SIGNATURES)"""
function irregularsquasher()
    join([
        "% Irregular form acceptor:",
        raw"$=irregularclass$ = [#irregular#]",
        raw"$squashirregurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> [#stemchars#]+ <irregular> $=irregularclass$  [#morphtag#]+ <div>   $=irregularclass$ <irregular><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>"
    ], "\n")
end






"""Compose transducer for filtering infinitive verb forms.

$(SIGNATURES)
"""
function infinitivesquasher()
    join(["% Infinitive acceptor",
    raw"$=verbclass$ = [#verbclass#]",
    raw"$squashinfinitiveurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<finiteverb>$=verbclass$  <div> $=verbclass$  <infinitive>  [#stemchars#]* $tense$ $voice$ <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>"
    ], "\n")
end


"""Compose transducer for filtering participial forms.

$(SIGNATURES)
"""
function participlesquasher()
    join(["% Participle acceptor",
    raw"$=verbclass$ = [#verbclass#]",
    raw"$squashparticipleurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<finiteverb>$=verbclass$  <div> $=verbclass$  <participle>  [#stemchars#]* $tense$ $voice$ $gender$ $case$ $number$  <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>"], "\n")
end




"""Compose transducer for filtering verbal adjectives.

$(SIGNATURES)
"""
function verbaladjectivesquasher()
    join(["% Verbal adjective acceptor",
    raw"$=verbclass$ = [#verbclass#]",
    raw"$squashverbaladjectiveurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<finiteverb>$=verbclass$  <div> $=verbclass$  <verbaladjective>  [#stemchars#]* $gender$ $case$ $number$  <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>"], "\n")
end


"""Compose transducer for filtering adjective forms.

$(SIGNATURES)
"""
function adjectivesquasher()
    join([
        "% Adjective acceptor:",
        raw"$=adjectiveclass$ = [#adjectiveclass#]",
        raw"$squashadjectiveurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<adjective>$=adjectiveclass$   <div> $=adjectiveclass$  <adjective> [#stemchars#]* $=gender$ $case$ $number$ $degree$ <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>"
        
    ], "\n")
end



"""Compose transducer for filtering pronoun forms.

$(SIGNATURES)
"""
function pronounsquasher()
    join([
        "% Pronoun acceptor:",
        raw"$=pronoun$ = [#pronoun#]",
        raw"$squashpronounurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>  <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> [#stemchars#]+ <pronoun> $gender$ $case$ $number$ $=pronoun$ <div> $=pronoun$<pronoun><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>",
    ], "\n")
end



"""Compose transducer for filtering finite verb forms.

$(SIGNATURES)"""
function finiteverbsquasher()
    join([raw"",
    raw"%% Put all symbols in 2 categories:  in τηε final transdcuer, we'll pass",
    raw"%% surface symbols through, and suppress analytical symbols.",
    raw"% Initially, though, we just let everything pass through:    ",
    raw"#analysissymbol# = #editorial# #urntag# #uninflected# #pos# #morphtag# #stemtype#  #separator#",
    raw"#surfacesymbol# = #letter# #morpheme#",
    raw"ALPHABET = [#surfacesymbol#] [#analysissymbol#]   ",
    raw"",
    raw"% Work on regular conjugation classes.",
    raw"% The acceptor transducer for finite verbs has four possibilities with distinct patterns:",
    raw"% reduplicated form, augmented form, reduplicated AND augmented, other form.",
    raw"% ",
    raw"% Possibility A: reduplicated form.  (perfect, pluperfect)",
    raw"% We can automate regular reduplication when stem starts with a consonant.",
    raw"",
    raw"$reduplicated$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]* <stem> {[#=consonant#]<>}:{<stem>[#=consonant#]ε[#=consonant#]}[#stemchars#]*  <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb> [#stemchars#]+ [#person#][#number#][#redupetense#][#mood#][#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>",
    raw"",
    raw"%",
    raw"% Possibility B: augmented form (imperfect, aorist, pluperfect indicative)",
    raw"",
    raw"% There are three patterns for augment:",
    raw"% 1. Simplex verb",
    raw"$simplex$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><stem>:[#augmentinitial#] [#stemchars#]+ <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb>  [#stemchars#]+ [#person#][#number#][#augmenttense#]<indicative>[#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>",
    raw"",
    raw"% 2. Compound with prefix ending in vowel.",
    raw"$compoundvowel$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]*[#vowel#]:<> {<stem><>}:{<stem>[#augmentmedial#]} [#stemchars#]+ <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb>  [#stemchars#]+ [#person#][#number#][#augmenttense#]<indicative>[#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>",
    raw"",
    raw"% 3. Compound with prefix ending in consonant (e.g., poetic apocope of prefix)",
    raw"$compoundconsonant$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]*[#consonant#] {<stem><>}:{<stem>[#augmentmedial#]} [#stemchars#]+ <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb>  [#stemchars#]+ [#person#][#number#][#augmenttense#]<indicative>[#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>",
    raw"",
    raw"% Final augment transducer is disjunction of these possiblities:",
    raw"$augment$ = ($compoundvowel$ | $compoundconsonant$ | $simplex$)",
    raw"%",
    raw"% Possiblity C: reduplicated AND augmented. (pluperfect indicative)",
    raw"$unsquashedredupe$ = <u>[#urnchar#]+\.[#urnchar#]+</u><u>[#urnchar#]+\.[#urnchar#]+</u>[#stemchars#]* <stem> {[#=consonant#]<>}:{<stem>[#=consonant#]ε[#=consonant#]}[#stemchars#]*  <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb> [#stemchars#]+ [#person#][#number#][#redupetense#][#mood#][#voice#]<u>[#urnchar#]+\.[#urnchar#]+</u>",
    raw"$plupft$ = $unsquashedredupe$ || $augment$",
    raw"%",
    raw"% Possiblity D: other finite verb forms.",
    raw"% Exclude indicative tenses that take augment:",
    raw"",
    raw"$finiteindic$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]* <stem> [#stemchars#]+<finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb>  [#stemchars#]+ [#person#][#number#][#unaugmented#]<indicative>[#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>",
    raw"",
    raw"% Allow all tenses of other moods:",
    raw"$otherfinite$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]* <stem> [#stemchars#]+ <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb> [#stemchars#]+ [#person#][#number#][#unaugmented#][#nonindicative#][#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>",
    raw"",
    raw"% Final transducer for other finite form:",
    raw"$finite$ = $finiteindic$ | $otherfinite$",
    raw"",
    raw"% Final transducer for all finite verbs:",
    raw"$squashverburn$ = ($reduplicated$ | $augment$ | $plupft$ | $finite$ )",
    raw""
        ], "\n")
end
#=
#include "/Users/nsmith/Desktop/linglat/morphology/parsers/shared-shared-xls-lat23/symbols.fst"











$=adjectiveclass$ = [#adjectiveclass#]
$squashadvurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<adj>$=adjectiveclass$   <div> $=adjectiveclass$  <adv> [#stemchars#]* $degree$ <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>



% Irregular adverb acceptor
$squashirregadvurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> [#stemchars#]+ $degree$ <irregadv> <div> <irregadv> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


% Irregular pronoun acceptor
$squashirregpronurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> [#stemchars#]+ $gender$ $case$ $number$ <irregpron> <div> <irregpron> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


% Irregular adjective acceptor
$squashirregadjurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> [#stemchars#]+ $gender$ $case$ $number$ $degree$ <irregadj> <div> <irregadj> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>



% Union of all URN squashers.

$acceptor$ = $squashverburn$ | $squashinfurn$ | $squashptcplurn$ | $squashgerundiveurn$ | $squashgerundurn$ | $squashsupineurn$ | $squashnounurn$ | $squashadjurn$ | $squashadvurn$ | $squashindeclurn$ | $squashirregverburn$ | $squashirreginfinnurn$ | $squashirregnounurn$ | $squashirregadjurn$ | $squashirregadvurn$ | $squashirregpronurn$

%% Put all symbols in 2 categories:  pass
%% surface symbols through, suppress analytical symbols.
#analysissymbol# = #editorial# #urntag# #indecl# #pos# #morphtag# #stemtype#  #separator#
#surfacesymbol# = #letter#
ALPHABET = [#surfacesymbol#] [#analysissymbol#]:<>
$stripsym$ = .+

%% The canonical pipeline: (morph data) -> acceptor -> parser/stripper
$acceptor$ || $stripsym$



=#