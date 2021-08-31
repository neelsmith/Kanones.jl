#include "/Users/nsmith/Desktop/greek2021/Kanones.jl/fst-scratch/augfull/symbols.fst"

%% Put all symbols in 2 categories:  in final transdcuer, we'll pass
%% surface symbols through, and suppress analytical symbols.
#analysissymbol# = #editorial# #urntag# #uninflected# #pos# #morphtag# #stemtype#  #separator#
#surfacesymbol# = #letter# #morpheme#
% Initially, just let everything pass through:    
ALPHABET = [#surfacesymbol#] [#analysissymbol#]   
$passthrough$ = .+

% The acceptor transducer for finite verbs has four possibilities with distinct patterns:
% reduplicated form, augmented form, reduplicated AND augmented, other form.
% 
% A: reduplicated form.  (perfect, pluperfect)
% We can automate regular reduplication when stem starts with a consonant.
#redupetense# = <pluperfect><perfect>
#=cons# = βγδζθκλμνξπρστφχψς
$reduplicated$ =  [#stemchars#]* <stem> {[#=cons#]<>}:{<stem>[#=cons#]ε[#=cons#]}[#stemchars#]* <div> [#stemchars#]+ [#redupetense#]

$redupe$ = $reduplicated$  | $passthrough$

% B: augmented form (imperfect, aorist, pluperfect indicative)
#augmenttense# = <imperfect><aorist><pluperfect>
#augmentinitial# = ἐ
#augmentmedial# = ε

% There are three patterns for augment:
% 1. Simplex verb
$simplex$ = <stem>:[#augmentinitial#] [#stemchars#]+ <div> [#stemchars#]+ [#augmenttense#]
% 2. Compound with prefix ending in vowel.
$compoundvowel$ = [#stemchars#]*[#vowel#]:<> {<stem><>}:{<stem>[#augmentmedial#]} [#stemchars#]+ <div> [#stemchars#]+ [#augmenttense#]
% 3. Compound with prefix ending in consonant (e.g., poetic apocope of prefix)
$compoundconsonant$ = [#stemchars#]*[#consonant#] {<stem><>}:{<stem>[#augmentmedial#]} [#stemchars#]+ <div> [#stemchars#]+ [#augmenttense#]
$augment$ = ($compoundvowel$ | $compoundconsonant$ | $simplex$)



% C: reduplicated AND augmented. (pluperfect indicative)



% D: other finite verb forms.






ALPHABET = [#surfacesymbol#] [#analysissymbol#]:<>
$stripsym$ = .+

$redupe$ | $augment$  || $stripsym$