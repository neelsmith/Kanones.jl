% Read the lexical items from a separate file
$WORDS$ = "verbs.txt"
% Define a transducer for the inflectional endings
$INFL$ = (<imperfect>ησε | <present>ει)

% Concatenate the lexical forms and the inflectional endings and
% put a boundary in between
$morph$ = $WORDS$ <div> $INFL$



% Define the set of valid symbol pairs for the two-level rules.
ALPHABET = [α-ω] ἐ <stem> <stem>:ἐ <imperfect> <present> <div>

#alpha# = α-ω
#cons# = βγδκφτπ
$augment$ = <stem><=>ἐ ([#cons#] [#alpha#]+ <div><imperfect> )
$pres$ = <stem>[#alpha#]+<div><present>[#alpha#]+

$verbs$ = $augment$ | $pres$

% Apply the two level rules
% The result transducer is stored in the output file
$augmented$ = $morph$ || $verbs$



#alphachars# = α-ω ἐ
#analysis# = <stem><imperfect><present><div>
ALPHABET = [#alphachars#] [#analysis#]:<>
$stripsym$ = .+


$augmented$ || $stripsym$

