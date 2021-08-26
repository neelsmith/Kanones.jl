% Read the lexical items from a separate file
$WORDS$ = "verbs.txt"
% Define a transducer for the inflectional endings
$INFL$ = (<imperfect>ησε | <present>ει)

% Concatenate the lexical forms and the inflectional endings and
% put a boundary in between
$morph$ = $WORDS$ <div> $INFL$



% Define the set of valid symbol pairs for the two-level rules.
ALPHABET = [α-ω] [a-z] ἐ <stem> <stem>:ἐ <imperfect> <present> <finiteverb><ew_contract> <div> <u></u>

%  <u>[#alpha#]:<>+</u>
#urnchar# = a-z
#alpha# = α-ω
#cons# = βγδκφτπ
$augment$ = (<u>[#urnchar#]:<>+</u><u>[#urnchar#]:<>+</u>) <stem><=>ἐ ([#cons#] [#alpha#]+ <finiteverb><ew_contract><div><imperfect> )
$pres$ = <u>[#alpha#]:<>+</u><u>[#alpha#]:<>+</u><stem>[#alpha#]+<finiteverb><ew_contract><div><present>[#alpha#]+

$verbs$ = $augment$ | $pres$

% Apply the two level rules
% The result transducer is stored in the output file
$augmented$ = $morph$ || $verbs$



#alphachars# = α-ω ἐ
#analysis# = <stem><imperfect><present><div><u></u><finiteverb><ew_contract>
ALPHABET = [#alphachars#] [#analysis#]:<>
$stripsym$ = .+


$augmented$ || $stripsym$

