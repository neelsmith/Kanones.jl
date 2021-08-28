% Read the lexical items from a separate file
$WORDS$ = "verbs.txt"
% Define a transducer for the inflectional endings
$INFL$ = ηκε<perfect>

% Concatenate the lexical forms and the inflectional endings and
% put a boundary in between
$morph$ = $WORDS$ <div> %$INFL$



% Define the set of valid symbol pairs for the two-level rules.
ALPHABET = [α-ω] <stem> {<stem>}:{πε} <perfects> <div>

#urnchar# = a-z
#alpha# = α-ω
$covfefe$ = π<>:{επ} | β<>:{εβ}
$redupe$ = $covfefe$ ^-> (<stem> __ <div>) % [#alpha#]+ <perfect>)
$verbs$ = $redupe$ 

% Apply the two level rules
% The result transducer is stored in the output file
$greek$ = $morph$ || $verbs$



#alphachars# = α-ω
#analysis# = <stem><perfect><div>
ALPHABET = [#alphachars#] [#analysis#]:<>
$stripsym$ = .+


$greek$  || $stripsym$
%$morph$

