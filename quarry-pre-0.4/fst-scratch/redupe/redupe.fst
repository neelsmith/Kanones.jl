% Read the lexical items from a separate file
$WORDS$ = "verbs.txt"
% Define a transducer for the inflectional endings
$INFL$ = <ew_contract><finiteverb>ηκε<third><singular><perfect><indicative><active><u>urnx</u>

% Concatenate the lexical forms and the inflectional endings and
% put a boundary in between
$morph$ = $WORDS$ <div> $INFL$



% Define the set of valid symbol pairs for the two-level rules.
ALPHABET = [α-ω] [a-z]:<> <u>:<> </u>:<> <stem><third><singular><perfect><indicative><active> <div><ew_contract><finiteverb>{<stem>}:{πε} 
#urnchar# = a-z
#alpha# = α-ω
$covfefe$ = π<>:{επ} | β<>:{εβ}
$redupe$ = $covfefe$ ^-> (<u>[#urnchar#]+</u><u>[#urnchar#]+</u><stem> __ [#alpha#]+ <finiteverb><ew_contract><div><ew_contract><finiteverb>  [#alpha#]+ <third><singular><perfect><indicative><active><u>[#urnchar#]+</u>)



$verbs$ = $redupe$ 

% Apply the two level rules
% The result transducer is stored in the output file
$greek$ = $morph$ || $verbs$



#alphachars# = α-ω
#analysis# = <stem><perfect><div><ew_contract><finiteverb><third><singular><perfect><indicative><active>
ALPHABET = [#alphachars#] [#analysis#]:<>
$stripsym$ = .+


$greek$  || $stripsym$
%$morph$

