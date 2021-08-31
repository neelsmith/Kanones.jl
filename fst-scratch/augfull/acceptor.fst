#include "/Users/nsmith/Desktop/greek2021/Kanones.jl/fst-scratch/augfull/symbols.fst"

%% Put all symbols in 2 categories:  in final transdcuer, we'll pass
%% surface symbols through, and suppress analytical symbols.
#analysissymbol# = #editorial# #urntag# #uninflected# #pos# #morphtag# #stemtype#  #separator#
#surfacesymbol# = #letter# #morpheme#
% Initially, just let everything pass through:    
ALPHABET = [#surfacesymbol#] [#analysissymbol#]   

% The acceptor transducer for finite verbs has three stages:
% reduplicated form, augmented form, other form.
% 
% A (stage 1): reduplication.
#redupetense# = <pluperfect><perfect>

% We can automate regular reduplication when stem starts with a consonant.
% There are two patterns for reduplication: simplex and compound verbs.

#=cons# = βγδζθκλμνξπρστφχψς
$simplexredupe$ =  <stem> {[#=cons#]<>}:{<stem>[#=cons#]ε[#=cons#]}[#stemchars#]* <div> [#stemchars#]+ [#redupetense#]

$simplexredupe1$ =<stem> {π<>}:{<stem>πεπ}[#stemchars#]* <div> [#stemchars#]+ [#redupetense#]


% B (stage 2): augment.
#augmenttense# = <imperfect><aorist><pluperfect>
#augmentinitial# = ἐ
#augmentmedial# = ε

% There are three patterns for augment:
% 1. Simplex verb
$simplex$ = <stem>:[#augmentinitial#] [#stemchars#]+ <div> [#stemchars#]+ [#augmenttense#]
% 2. Compound with prefix ending in vowel.
$compoundvowel$ = [#stemchars#]*[#vowel#]:<> {<stem><>}:{<stem>[#augmentmedial#]} [#stemchars#]+ <div> [#stemchars#]+ [#augmenttense#]
% 2. Compound with prefix ending in consonant (e.g., poetic apocope of prefix)
$compoundconsonant$ = [#stemchars#]*[#consonant#] {<stem><>}:{<stem>[#augmentmedial#]} [#stemchars#]+ <div> [#stemchars#]+ [#augmenttense#]
$augment$ = ($compoundvowel$ | $compoundconsonant$ | $simplex$)

ALPHABET = [#surfacesymbol#] [#analysissymbol#]:<>
$stripsym$ = .+

%$augment$ || $stripsym$


$simplexredupe$ || $stripsym$