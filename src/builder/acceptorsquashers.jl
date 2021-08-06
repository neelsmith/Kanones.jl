
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
        adjectivesquasher()

    ], "\n")
    squasherunion = join([
        "% Union of all URN squashers:",
        raw"$acceptor$ = $squashuninflurn$ | $squashnounurn$ | $squashirregurn$ | $squashverburn$ | $squashinfinitiveurn$ | $squashparticipleurn$ | $squashverbaladjectiveurn$ | $squashadjectiveurn$ "
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




"""Compose transducer for filtering finite verb forms.

$(SIGNATURES)"""
function finiteverbsquasher()
    join(["% Conjugated verb form acceptor",
    raw"$=verbclass$ = [#verbclass#]",
    raw"$squashverburn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> [#stemchars#]+<finiteverb>$=verbclass$ <div> $=verbclass$ <finiteverb> [#stemchars#]* [#person#] [#number#] [#tense#] [#mood#] [#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>",
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