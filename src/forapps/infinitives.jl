function infinitives_md(lexu::LexemeUrn, kd::Kanones.FilesDataset; include_future = false)
    pres_act = GMFInfinitive(
        gmpTense("present"), gmpVoice("active")
    ) |> formurn
    pres_mp = GMFInfinitive(
        gmpTense("present"), gmpVoice("middle")
    ) |> formurn
    pres_actforms = generate(lexu, pres_act, kd)
    pres_mpforms = generate(lexu, pres_mp, kd)

    # SKIP FUTURE FOR THE MOMENT...

    aor_act = GMFInfinitive(
        gmpTense("aorist"), gmpVoice("active")
    ) |> formurn
    aor_m = GMFInfinitive(
        gmpTense("aorist"), gmpVoice("middle")
    ) |> formurn
    aor_p = GMFInfinitive(
        gmpTense("aorist"), gmpVoice("passive")
    ) |> formurn

    aor_actforms = generate(lexu, aor_act, kd)
    aor_mforms = generate(lexu, aor_m, kd)
    aor_pforms = generate(lexu, aor_p, kd)

    pft_act = GMFInfinitive(
        gmpTense("perfect"), gmpVoice("active")
    ) |> formurn
    pft_mp = GMFInfinitive(
        gmpTense("perfect"), gmpVoice("middle")
    ) |> formurn
   

   pft_actforms = generate(lexu, pft_act, kd)
   pft_mpforms = generate(lexu, pft_mp, kd)
    

   mdlines = [
    "| Tense | Active | Middle | Passive |" ,
    "| --- | --- | --- | ---  |",
    """| Present | $(join(pres_actforms, ", "))|  $(join(pres_mpforms, ", ")) |   $(join(pres_mpforms, ", ")) |""",
    "| Aorist | $(join(aor_actforms, ", ")) | $(join(aor_mforms, ", ")) | $(join(aor_pforms, ", ")) |",
    "| Perfect |  $(join(pft_actforms, ", "))|  $(join(pft_mpforms, ", ")) | $(join(pft_mpforms, ", ")) |"
   ]

   join(mdlines,"\n")
end