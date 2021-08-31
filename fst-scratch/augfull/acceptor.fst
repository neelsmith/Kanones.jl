#include "/Users/nsmith/Desktop/greek2021/Kanones.jl/fst-scratch/augfull/symbols.fst"

#augmentinitial# = ἐ
#augmentmedial# = ε

%% Put all symbols in 2 categories:  pass
%% surface symbols through, suppress analytical symbols.
#analysissymbol# = #editorial# #urntag# #uninflected# #pos# #morphtag# #stemtype#  #separator# #morpheme#
#surfacesymbol# = #letter#


#augmenttense# = <imperfect><aorist><pluperfect>

ALPHABET = [#surfacesymbol#] [#analysissymbol#]     
$compoundvowel$ = [#stemchars#]*[#vowel#]:<> <stem>:[#augmentmedial#] [#stemchars#]+ <div> [#stemchars#]+ [#augmenttense#]
$compoundconsonant$ = [#stemchars#]*[#consonant#] <stem>:[#augmentmedial#] [#stemchars#]+ <div> [#stemchars#]+ [#augmenttense#]



$compoundaug$ = $compoundvowel$ | $compoundconsonant$


$simplex$ = <stem>:[#augmentinitial#] [#stemchars#]+ <div> [#stemchars#]+ <aorist> 

ALPHABET = [#surfacesymbol#] [#analysissymbol#]:<>
$stripsym$ = .+



%($compoundaug$ | $simplex$) || $stripsym$

$compoundaug$ || $stripsym$
