% Read the lexical items from a separate file
$WORDS$ = "verbs2.txt"
% Define a transducer for the inflectional endings
$INFL$ = (<ew_contract><finiteverb>ησε<third><singular><aorist><indicative><active><u>urnx</urn> | <ew_contract><finiteverb>ει<third><singular><present><indicative><active><u>urny</u>)

% Concatenate the lexical forms and the inflectional endings and
% put a boundary in between
$morph$ = $WORDS$ <div> $INFL$


$covfefe$ = <stem>:ἐ

% Define the set of valid symbol pairs for the two-level rules.
ALPHABET = [α-ω] [a-z]:<> ἐ <stem> <third><singular><aorist><present> <indicative><active><finiteverb><ew_contract> <div> <u>:<> </u>:<>

#urnchar# = a-z
#alpha# = α-ω
#cons# = βγδκφτπ
%$augment$ = (<u>[#urnchar#]+</u><u>[#urnchar#]+</u>) <stem><=>ἐ ([#cons#] [#alpha#]+ <finiteverb><ew_contract><div><ew_contract><finiteverb>[#alpha#]+<third><singular><aorist><indicative><active><u>[#urnchar#]+</u> )


$augment$ = $covfefe$  ^-> (<u>[#urnchar#]+</u>) __ ([#cons#][#alpha#]+<finiteverb><ew_contract><div><ew_contract><finiteverb>[#alpha#]+<third><singular><aorist>)



%ALPHABET = [α-ω] [a-z]:<> ἐ <stem> <third><singular><aorist><present> <indicative><active><finiteverb><ew_contract> <div> <u>:<> </u>:<> <stem>:<>
%$pres$ = (<u>[#urnchar#]+</u><u>[#urnchar#]+</u>) <stem><=><> (<stem>[#alpha#]+<finiteverb><ew_contract><div><ew_contract><finiteverb>[#alpha#]+<third><singular><present><indicative><active><u>[#urnchar#]+</u>)

$verbs$ =  $augment$  % $pres$ %| 

% Apply the two level rules
% The result transducer is stored in the output file
$augmented$ = $morph$ || $verbs$



#alphachars# = α-ω ἐ
#analysis# = stem><third><singular><aorist><present><indicative><active><div><u></u><finiteverb><ew_contract>
%ALPHABET = [#alphachars#] [#analysis#]:<>
%$stripsym$ = .+


$augmented$ %|| $stripsym$
%$morph$

