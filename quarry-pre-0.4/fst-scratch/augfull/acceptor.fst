#include "/Users/nsmith/Desktop/greek2021/Kanones.jl/fst-scratch/augfull/symbols.fst"

%% Put all symbols in 2 categories:  in τηε final transdcuer, we'll pass
%% surface symbols through, and suppress analytical symbols.
% Initially, though, we just let everything pass through:    
#analysissymbol# = #editorial# #urntag# #uninflected# #pos# #morphtag# #stemtype#  #separator#
#surfacesymbol# = #letter# #morpheme#
ALPHABET = [#surfacesymbol#] [#analysissymbol#]   

% Work on regular conjugation classes.
% The acceptor transducer for finite verbs has four possibilities with distinct patterns:
% reduplicated form, augmented form, reduplicated AND augmented, other form.
% 
% Possibility A: reduplicated form.  (perfect, pluperfect)
% We can automate regular reduplication when stem starts with a consonant.

$reduplicated$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]* <stem> {[#=consonant#]<>}:{<stem>[#=consonant#]ε[#=consonant#]}[#stemchars#]*  <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb> [#stemchars#]+ [#person#][#number#][#redupetense#][#mood#][#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>

%
% Possibility B: augmented form (imperfect, aorist, pluperfect indicative)

% There are three patterns for augment:
% 1. Simplex verb
$simplex$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><stem>:[#augmentinitial#] [#stemchars#]+ <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb>  [#stemchars#]+ [#person#][#number#][#augmenttense#]<indicative>[#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>

% 2. Compound with prefix ending in vowel.
$compoundvowel$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]*[#vowel#]:<> {<stem><>}:{<stem>[#augmentmedial#]} [#stemchars#]+ <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb>  [#stemchars#]+ [#person#][#number#][#augmenttense#]<indicative>[#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>

% 3. Compound with prefix ending in consonant (e.g., poetic apocope of prefix)
$compoundconsonant$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]*[#consonant#] {<stem><>}:{<stem>[#augmentmedial#]} [#stemchars#]+ <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb>  [#stemchars#]+ [#person#][#number#][#augmenttense#]<indicative>[#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>

% Final augment transducer is disjunction of these possiblities:
$augment$ = ($compoundvowel$ | $compoundconsonant$ | $simplex$)
%
% Possiblity C: reduplicated AND augmented. (pluperfect indicative)
$unsquashedredupe$ = <u>[#urnchar#]+\.[#urnchar#]+</u><u>[#urnchar#]+\.[#urnchar#]+</u>[#stemchars#]* <stem> {[#=consonant#]<>}:{<stem>[#=consonant#]ε[#=consonant#]}[#stemchars#]*  <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb> [#stemchars#]+ [#person#][#number#][#redupetense#][#mood#][#voice#]<u>[#urnchar#]+\.[#urnchar#]+</u>
$plupft$ = $unsquashedredupe$ || $augment$
%
% Possiblity D: other finite verb forms.
% Exclude indicative tenses that take augment:

$finiteindic$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]* <stem> [#stemchars#]+<finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb>  [#stemchars#]+ [#person#][#number#][#unaugmented#]<indicative>[#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>

% Allow all tenses of other moods:
$otherfinite$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]* <stem> [#stemchars#]+ <finiteverb>[#=regularclass#] <div> [#=regularclass#]<finiteverb> [#stemchars#]+ [#person#][#number#][#unaugmented#][#nonindicative#][#voice#]<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>

% Final transducer for other finite form:
$finite$ = $finiteindic$ | $otherfinite$

% Redefine alphabet to suppress all analytical symbols from surface form:
ALPHABET = [#surfacesymbol#] [#analysissymbol#]:<>
$stripsym$ = .+

($reduplicated$ | $augment$ | $plupft$ | $finite$ )   || $stripsym$
