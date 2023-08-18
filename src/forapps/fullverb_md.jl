function verb_conjugation_md(lexu::LexemeUrn, kd::Kanones.FilesDataset)

    mdoutput = [
    "## Present system","",
    "### Present tense","",
    "*Active voice*:","",
    md_conjugation(gmpTense("present"), gmpVoice("active"), lexu, kd)
    ]

   

    join(mdoutput, "\n")
end