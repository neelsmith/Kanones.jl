
"""Compose `acceptor.fst` and write to file `target`.

$(SIGNATURES)
"""
function buildacceptor(src, target)
    fstroot = dirname(target)
    incl = string("#include \"", fstroot, "/symbols.fst\"")

    squashers = join([
        uninflsquasher(),
        nounsquasher()
    ], "\n")
    squasherunion = join([
        "% Union of all URN squashers:",
        raw"$acceptor$ = $squashuninflurn$ | $squashnounurn$"
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


#=
#include "/Users/nsmith/Desktop/linglat/morphology/parsers/shared-shared-xls-lat23/symbols.fst"

% Conjugated verb form acceptor
$=verbclass$ = [#verbclass#]
$squashverburn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<verb>$=verbclass$  $separator$+$=verbclass$ <verb>[#stemchars#]* [#person#] [#number#] [#tense#] [#mood#] [#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


% Indeclinable form acceptor:
$=indeclclass$ = [#indecl#]
$squashindeclurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> [#stemchars#]+ <indecl> $=indeclclass$ <div>   $=indeclclass$ <indecl><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


% Infinitive acceptor
$=verbclass$ = [#verbclass#]
$squashinfurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<verb>$=verbclass$  <div> $=verbclass$  <infin>  [#stemchars#]* $tense$ $voice$ <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


% Participle acceptor
$=verbclass$ = [#verbclass#]
$squashptcplurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<verb>$=verbclass$  <div> $=verbclass$  <ptcpl>  [#stemchars#]* $gender$ $case$ $number$ $tense$ $voice$ <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


% Gerundive acceptor
$=verbclass$ = [#verbclass#]
$squashgerundiveurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<verb>$=verbclass$ <div> $=verbclass$ <gerundive>[#stemchars#]* [#gender#] [#case#][#number#] <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


% Gerund acceptor
$=verbclass$ = [#verbclass#]
$squashgerundurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<verb>$=verbclass$ <div> $=verbclass$ <gerund>[#stemchars#]* [#case#] <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


% Supine acceptor
$=verbclass$ = [#verbclass#]
$squashsupineurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<verb>$=verbclass$ <div> $=verbclass$ <supine>[#stemchars#]* [#case#] <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


% Noun acceptor:
$=nounclass$ = [#nounclass#]
$squashnounurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<noun>$=gender$ $=nounclass$   <div> $=nounclass$  <noun> [#stemchars#]* $=gender$ $case$ $number$ <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


% Adjective acceptor:
$=adjectiveclass$ = [#adjectiveclass#]
$squashadjurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<adj>$=adjectiveclass$   <div> $=adjectiveclass$  <adj> [#stemchars#]* $=gender$ $case$ $number$ $degree$ <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


$=adjectiveclass$ = [#adjectiveclass#]
$squashadvurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<adj>$=adjectiveclass$   <div> $=adjectiveclass$  <adv> [#stemchars#]* $degree$ <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


% Irregular verb acceptor
$squashirregverburn$ =  <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+[#person#] [#number#] [#tense#] [#mood#] [#voice#]<irregcverb><div><irregcverb><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


% Irregular infinitive acceptor
$squashirreginfinnurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> [#stemchars#]+ $tense$ $voice$ <irreginfin> <div> <irreginfin> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>






% Irregular noun acceptor
$squashirregnounurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> [#stemchars#]+ $gender$ $case$ $number$ <irregnoun> <div> <irregnoun> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>


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