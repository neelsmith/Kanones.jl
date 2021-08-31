#include "/Users/nsmith/Desktop/greek2021/Kanones.jl/fst-scratch/augfull/symbols.fst"

%% Put all symbols in 2 categories:  in τηε final transdcuer, we'll pass
%% surface symbols through, and suppress analytical symbols.
% Initially, though, we just let everything pass through:    
#analysissymbol# = #editorial# #urntag# #uninflected# #pos# #morphtag# #stemtype#  #separator#
#surfacesymbol# = #letter# #morpheme#

ALPHABET = [#surfacesymbol#] [#analysissymbol#]   
$passthrough$ = .+


% Work on regular conjugation classes.
#=regularclass# =  <w_regular> <ew_contract> <short_ew_contract><aw_contract> <long_aw_contract><ow_contract>
% The acceptor transducer for finite verbs has four possibilities with distinct patterns:
% reduplicated form, augmented form, reduplicated AND augmented, other form.
% 
% Possibility A: reduplicated form.  (perfect, pluperfect)
% We can automate regular reduplication when stem starts with a consonant.
#redupetense# = <pluperfect><perfect>
#=cons# = βγδζθκλμνξπρστφχψς
$reduplicated$ =  [#stemchars#]* <stem> {[#=cons#]<>}:{<stem>[#=cons#]ε[#=cons#]}[#stemchars#]*  <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb> [#stemchars#]+ [#redupetense#][#mood#][#voice#]
%
%
% Possibility B: augmented form (imperfect, aorist, pluperfect indicative)
#augmenttense# = <imperfect><aorist><pluperfect>
#augmentinitial# = ἐ
#augmentmedial# = ε
% There are three patterns for augment:
% 1. Simplex verb
$simplex$ = <stem>:[#augmentinitial#] [#stemchars#]+ <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb>  [#stemchars#]+ [#augmenttense#]<indicative>[#voice#]
% 2. Compound with prefix ending in vowel.
$compoundvowel$ = [#stemchars#]*[#vowel#]:<> {<stem><>}:{<stem>[#augmentmedial#]} [#stemchars#]+ <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb>  [#stemchars#]+ [#augmenttense#]<indicative>[#voice#]
% 3. Compound with prefix ending in consonant (e.g., poetic apocope of prefix)
$compoundconsonant$ = [#stemchars#]*[#consonant#] {<stem><>}:{<stem>[#augmentmedial#]} [#stemchars#]+ <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb>  [#stemchars#]+ [#augmenttense#]<indicative>[#voice#]
% Final augment transducer is disjunction of these possiblities:
$augment$ = ($compoundvowel$ | $compoundconsonant$ | $simplex$)


% Possiblity C: reduplicated AND augmented. (pluperfect indicative)
$plupft$ = $reduplicated$ || $augment$

% Possiblity D: other finite verb forms.
%
% Exclude indicative tenses that take augment:
#unaugmented# = <present><future><pluperfect>
#nonindicative# = <subjunctive><optative><imperative>
$finiteindic$ = [#stemchars#]* <stem> [#stemchars#]+<finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb>  [#stemchars#]+ [#unaugmented#]<indicative>[#voice#]
% Allow all tenses of other moods:
$otherfinite$ = [#stemchars#]* <stem> [#stemchars#]+ <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb> [#stemchars#]+ [#unaugmented#][#nonindicative#][#voice#]
% Final transducer for other finite form:
$finite$ = $finiteindic$ | $otherfinite$

ALPHABET = [#surfacesymbol#] [#analysissymbol#]:<>
$stripsym$ = .+

($reduplicated$ | $augment$ | $plupft$ | $finite$ )  || $stripsym$
