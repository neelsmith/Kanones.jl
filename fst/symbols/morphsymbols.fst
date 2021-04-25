% morphsymbols.fst
%
% Definitions of all symbols used to express a morphological analysis
%
% "Parts of speech": not traditional definition, but distinguished by
% analytical pattern.  E.g., <infin> has distinct pattern that is neither
% noun nor verb.
#pos# = <noun><adjective><finiteverb><vadj><infinitive><participle><adverb><pronoun><uninflected><irregular>
#verbparts# = <finiteverb><vadj><infinitive><participle>
%
% 1. Noun morphology:
%
#gender# = <masculine><feminine><neuter>
#case# = <nominative><accusative><genitive><dative><vocative>
#number# = <singular><dual><plural>
%
% 2. Adjective morphology:
%
#degree# = <positive><comparative><superlative>
%
% 3. Verb morphology:
%
#person# = <1st><2nd><3rd>
% number already defined in noun morphology
#tense# = <present><imperfect><future><aorist><perfect><pluperfect>
#mood# = <indicactive><subj><opt><imptv>
#voice# = <active><middle><passive>
#vadj# =  <vadj1><vadj2>
#finiteform# = <infinitive><participle><vadj1><vadj2>

%
% 4. Uninflected forms:
%
#uninflected# =  <conjunction><particle><interjection><preposition><adverb><numeral>


%
% 5. Irregular forms:
%
#irregular# =  <irregularnoun><irregularfiniteverb><irregularinfinitive><irregularadjective>

#morphtag# = #pos# #gender# #case# #number# #person# #tense# #mood# #voice# #degree# #finiteform# #uninflected# #irregular# 


% Consider whether those belong here or elsewhere...?

% Transducers for the above variables:
$gender$ = [#gender#]
$case$ = [#case#]
$number$ = [#number#]
$degree$ = [#degree#]

$person$ = [#person#]
$tense$ = [#tense#]
$mood$ = [#mood#]
$voice$ = [#voice#]

$vadj$ = [#vadj#]

% Identity variables for the transducers:
$=gender$ = [#gender#]
$=case$ = [#case#]
$=number$ = [#number#]
