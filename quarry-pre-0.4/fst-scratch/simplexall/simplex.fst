% Read the lexical items from a separate file
$WORDS$ = "verbs.txt"
% Define a transducer for the inflectional endings
$INFL$ = (<ew_contract><finiteverb>ησε<third><singular><aorist><indicative><active><u>urnx</urn> | <ew_contract><finiteverb>ει<third><singular><present><indicative><active><u>urny</u> | <ew_contract><finiteverb>ηκε<third><singular><perfect><indicative><active><u>urnz</u>)

% Concatenate the lexical forms and the inflectional endings and
% put a boundary in between
$morph$ = $WORDS$ <div> $INFL$

% 1. REDUPLICATE.
% Define the set of valid symbol pairs for the two-level rules.
ALPHABET = [α-ω] [a-z]:<> <u>:<> </u>:<> <stem><third><singular><perfect><indicative><active> <div><ew_contract><finiteverb>{<stem>}:{πε} 
#urnchar# = a-z
#alpha# = α-ω
$covfefe$ = π<>:{επ} | β<>:{εβ}
$redupe$ = $covfefe$ ^-> (<u>[#urnchar#]+</u><u>[#urnchar#]+</u><stem> __ [#alpha#]+ <finiteverb><ew_contract><div><ew_contract><finiteverb>  [#alpha#]+ <third><singular><perfect><indicative><active><u>[#urnchar#]+</u>)




% 2. AUGMENT
% Define the set of valid symbol pairs for the two-level rules.
ALPHABET = [α-ω] [a-z]:<> ἐ <stem> <stem>:ἐ  <stem>:<> <third><singular><aorist><present><perfect> <indicative><active><finiteverb><ew_contract> <div> <u>:<> </u>:<>

#urnchar# = a-z
#alpha# = α-ω
#cons# = βγδκφτπ
$augment$ = (<u>[#urnchar#]+</u><u>[#urnchar#]+</u>) <stem><=>ἐ ([#cons#] [#alpha#]+ <finiteverb><ew_contract><div><ew_contract><finiteverb>[#alpha#]+<third><singular><aorist><indicative><active><u>[#urnchar#]+</u> )

$pres$ = (<u>[#urnchar#]+</u><u>[#urnchar#]+</u>) <stem><=><> (<stem>[#alpha#]+<finiteverb><ew_contract><div><ew_contract><finiteverb>[#alpha#]+<third><singular><present><indicative><active><u>[#urnchar#]+</u>)

$verbs$ = $redupe$  | $augment$ | $pres$

% Apply the two level rules
% The result transducer is stored in the output file
$augmented$ = $morph$ || $verbs$



#alphachars# = α-ω ἐ
#analysis# = stem><third><singular><aorist><present><perfect> <indicative><active><div><u></u><finiteverb><ew_contract>
ALPHABET = [#alphachars#] [#analysis#]:<>
$stripsym$ = .+


$augmented$ || $stripsym$
%$morph$

