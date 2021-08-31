% phonology.fst
%
% Definitions of all legal symbols in stem files (lexica) except for
% stem types (defined in stemtypes.fst)
%
% Basic alphabet specific to this orthographic system:
#include "/Users/nsmith/Desktop/greek2021/Kanones.jl/parsers/lysiasparser//symbols/alphabet.fst"

% phonology.fst
%
% Definitions of all legal symbols in stem files (lexica) except for
% stem types (defined in stemtypes.fst)
%
% Basic alphabet specific to this orthographic system:
#letter# = #consonant# #vowel#

% Note that accents should only be included in entries for
% irregular forms!

#morpheme# = <stem>
#character# = #letter#
$character$ = [#character#]

% Additional editorial symbols used in stem files:
#vowelquant# = _^
#persistacc# = <stemaccented><recessive><inflectionaccented><irregularaccent>
#editorial# = #morpheme# #persistacc#  #vowelquant#
% Transducer for persistent accent for convenenient
% composition
$persistacc$ = [#persistacc#]

% All valid chars used in stem file:
#stemchars# = #character# #editorial#
#inmorpheme# = #character# #vowelquant# #persistacc#


