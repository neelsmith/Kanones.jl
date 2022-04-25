% morphsymbols.fst
%
% Definitions of all symbols used to express a morphological analysis
%
% "Parts of speech": not traditional definition, but distinguished by
% analytical pattern.  E.g., <infin> has distinct pattern that is neither
% noun nor verb.
#pos# = <noun><adjective><finiteverb><verbaladjective><infinitive><participle><adverb><pronoun><uninflected><irregular>
#verbparts# = <finiteverb><verbaladjective><infinitive><participle>
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
#person# = <first><second><third>
% number already defined in noun morphology
#tense# = <present><imperfect><future><aorist><perfect><pluperfect>
#mood# = <indicative><subjunctive><optative><imperative>
#voice# = <active><middle><passive>
#vadj# =  <vadj1><vadj2>
#nonfiniteform# = <infinitive><participle><vadj1><vadj2>
#nonindicative# = <subjunctive><optative><imperative>
#augmenttense# = <imperfect><aorist><pluperfect>
#unaugmented# = <present><future><pluperfect>
#redupetense# = <pluperfect><perfect>

%
% 4. Uninflected forms:
%
#uninflected# =  <conjunction><particle><interjection><preposition><adverb><numeral>


%
% 5. Irregular forms:
%
#irregular# =  <irregularnoun><irregularfiniteverb><irregularinfinitive><irregularadjective>



%
% 6. Pronouns
%
#pronoun# = <article><demonstrative><interrogative><personal>

%
% 7. Morphological properties
%
#morphtag# = #pos# #gender# #case# #number# #person# #tense# #mood# #voice# #degree# #nonfiniteform# #uninflected# #irregular# #pronoun#
    
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

$=pronoun$ = [#pronoun#]
