% Read the lexical items from a separate file
$WORDS$ = "verbs.txt"
% Define a transducer for the inflectional endings
$INFL$ = (<ew_contract><finiteverb>ησε<third><singular><aorist><indicative><active> | <ew_contract><finiteverb>ει<third><singular><present><indicative><active>)

% Concatenate the lexical forms and the inflectional endings and
% put a boundary in between
$morph$ = $WORDS$ <div> $INFL$



% Define the set of valid symbol pairs for the two-level rules.
ALPHABET = [α-ω] [a-z] ἐ <stem> <stem>:ἐ  <stem>:<> <third><singular><aorist><present> <indicative><active><finiteverb><ew_contract> <div> <u></u>

#urnchar# = a-z
#alpha# = α-ω
#cons# = βγδκφτπ
$augment$ = (<u>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+</u>) <stem><=>ἐ ([#cons#] [#alpha#]+ <finiteverb><ew_contract><div><ew_contract><finiteverb>[#alpha#]+<third><singular><aorist><indicative><active> )

$pres$ = (<u>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+</u>) <stem><=><> (<stem>[#alpha#]+<finiteverb><ew_contract><div><ew_contract><finiteverb>[#alpha#]+<third><singular><present><indicative><active>)

$verbs$ = $augment$ | $pres$

% Apply the two level rules
% The result transducer is stored in the output file
$augmented$ = $morph$ || $verbs$



#alphachars# = α-ω ἐ
#analysis# = stem><third><singular><aorist><present><indicative><active><div><u></u><finiteverb><ew_contract>
ALPHABET = [#alphachars#] [#analysis#]:<>
$stripsym$ = .+


$augmented$ || $stripsym$
%$morph$

