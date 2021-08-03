% phonology.fst
%
% Definitions of all legal symbols in stem files (lexica) except for
% stem types (defined in stemtypes.fst)

%
% Basic alphabet specific to this orthographic system:

#letter# = #consonant# #vowel#


% Accents should only be included in entries for
% irregular forms!

#character# = #letter#
$character$ = [#character#]

% Additional editorial symbols used in stem files:
%#vowelquant# = <lo><sh>
#vowelquant# = _^
#morpheme# = <#>
#persistacc# = <stemaccented><recessive><inflectionaccented><irregularaccent>
#editorial# = #morpheme# #persistacc#  #vowelquant#
% Transducer for persistent accent for convenenient
% composition
$persistacc$ = [#persistacc#]

% All valid chars used in stem file:
#stemchars# = #character# #editorial#
#inmorpheme# = #character# #vowelquant# #persistacc#


% Temporary definition for debugging until this is implemented in 
% Greek alphabet API.
#augment# = ἐ
