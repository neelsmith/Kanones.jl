#include "/Users/nsmith/Desktop/greek2021/Kanones.jl/fst-scratch/augfull/symbols.fst"

% The acceptor transducer for finite verbs has three stages:
% reduplicated form, augmented form, other form.
% 
% A. Reduplication.






#augmentinitial# = ἐ
#augmentmedial# = ε

%% Put all symbols in 2 categories:  pass
%% surface symbols through, suppress analytical symbols.
#analysissymbol# = #editorial# #urntag# #uninflected# #pos# #morphtag# #stemtype#  #separator#
#surfacesymbol# = #letter# #morpheme#


#augmenttense# = <imperfect><aorist><pluperfect>

ALPHABET = [#surfacesymbol#] [#analysissymbol#]     
% Three patterns for augment:
% 1. Simplex verb
$simplex$ = <stem>:[#augmentinitial#] [#stemchars#]+ <div> [#stemchars#]+ <aorist> 
% 2. Compound with prefix ending in vowel.
$compoundvowel$ = [#stemchars#]*[#vowel#]:<> {<stem><>}:{<stem>[#augmentmedial#]} [#stemchars#]+ <div> [#stemchars#]+ [#augmenttense#]
% 2. Compound with prefix ending in consonant (e.g., poetic apocope of prefix)
$compoundconsonant$ = [#stemchars#]*[#consonant#] {<stem><>}:{<stem>[#augmentmedial#]} [#stemchars#]+ <div> [#stemchars#]+ [#augmenttense#]


ALPHABET = [#surfacesymbol#] [#analysissymbol#]:<>
$stripsym$ = .+



($compoundvowel$ | $compoundconsonant$ | $simplex$) || $stripsym$

%$compoundaug$ || $stripsym$
