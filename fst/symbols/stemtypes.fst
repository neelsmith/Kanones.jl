% stemtypes.fst
%
% Definitions of morphological stem types used to unite stem entries and
% inflectional patterns
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Noun stem types
#noun1# = <a_as><a_as_contr><a_as_short><a_hs><as_ou><as_ou_contr><h_hs><h_hs_contr><hs_ou><hs_ou_contr>

#noun2# = <os_ou><ous_ou><ous_ou_ult>


#labialpalatal3# = <y_pos><y_bos><c_kos><gc_ggos><c_gos><c_xos>
#dental3# = <s_tos><is_idos><is_itos><s_qos><s_ntos><wn_ontos>
#neuttau3# = <ma_matos><r_tos><s_tos>
#liquidnasal3# = <wr_oros><s_nos><wn_onos><hn_enos><0_os>
#rho3# = <hr_ros>
#sigma3# = <hs_ous><as_ws>
#iu3# = <is_ews><us_ews><us_uos>
#diphth3# = <eus_ews><w_ous>


#noun3# = #labialpalatal3#  #dental3# #neuttau3# #liquidnasal3# #rho3# #iu3#  #diphth3#

#irregnoun#  = <irregularnoun>

#nounclass# = #noun1# #noun2# #noun3# #irregnoun# 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pronoun stem types
%#pronoun# = <article><demonstrative><interrogative>




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adjective stem types
#adj1and2# = <os_h_on><os_a_on><os_h_on_pos><os_h_on_comp><os_h_on_superl>


#consplusvowelstem# = <us_eia_u>

#adjectiveclass# = #adj1and2# #consplusvowelstem# 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adverb stem types
#indecladv# = <indeclpos><indeclcomp><indeclsup>

#adverbclass# = #indecladv#

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Verb stem types
#omega# = <w_regular> <ew_contract> <short_ew_contract><aw_contract> <long_aw_contract><ow_contract>
#deponent# = <w_pp1_dep> <w_pp2_dep> <w_pp3_dep> <w_aor2_dep>
#omegaprincparts# = <w_pp1> <w_pp2> <w_pp3> <w_pp4> <w_pp5> <w_pp6> 
#perfectactives# = <g_pp5> <m_pp5> <s_pp5> <sm_pp5> <gm_pp5> <vowel_pp5>
#otherprincparts# = <attic_fut> <w_aor2>
#princparts# = #omegaprincparts#  #perfectactives#  #otherprincparts# 
#mi# = <numi_pres>
#verbaladjectives# = <vadj>

#verbclass#  = #omega# #mi# #princparts# #deponent# #verbaladjectives# 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Indeclinable type
#indeclclass# = <indeclconj><indeclparticle><indeclinterj><indeclprep>


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Irregular type
#irregclass# = <irregadj><irregnoun><irregadv><irregcverb><irreginfin><irregptcpl><irregvadj><irregpron>

% Union of all stemtypes
#stemtype# = #nounclass# #adjectiveclass# #adverbclass# #verbclass# #indeclclass# #irregclass#
