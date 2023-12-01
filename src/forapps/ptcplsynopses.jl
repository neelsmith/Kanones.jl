function ptcplsynopsis_md(
    lex::LexemeUrn, 
    kd::Kanones.FilesDataset)
    lines = [
    "| Tense voice | Nominative singular (m, f, n) | Genitive singular (m, f, n)|",
    "| --- | --- | --- |",
    ]

    presact = string("| Present active |",
    participleslashline(lex, gmpTense("present"), gmpVoice("active"), kd), " | ",
    participleslashline(lex, gmpTense("present"), gmpVoice("active"), kd, examplecase = gmpCase("genitive")), " |"
    )
    push!(lines, presact)

    presmid = string("| Present middle |",
    participleslashline(lex, gmpTense("present"), gmpVoice("middle"), kd), " | ",
    participleslashline(lex, gmpTense("present"), gmpVoice("middle"), kd, examplecase = gmpCase("genitive")), " |"
    )
    push!(lines, presmid)

    prespass = string("| Present passive |",
    participleslashline(lex, gmpTense("present"), gmpVoice("passive"), kd), " | ",
    participleslashline(lex, gmpTense("present"), gmpVoice("passive"), kd, examplecase = gmpCase("genitive")), " |"
    )
    push!(lines, prespass)




    aoract = string("| Aorist active |",
    participleslashline(lex, gmpTense("aorist"), gmpVoice("active"), kd), " | ",
    participleslashline(lex, gmpTense("aorist"), gmpVoice("active"), kd, examplecase = gmpCase("genitive")), " |"
    )
    push!(lines, aoract)

    aormid = string("| Aorist middle |",
    participleslashline(lex, gmpTense("aorist"), gmpVoice("middle"), kd), " | ",
    participleslashline(lex, gmpTense("aorist"), gmpVoice("middle"), kd, examplecase = gmpCase("genitive")), " |"
    )
    push!(lines, aormid)

    aorpass = string("| Aorist passive |",
    participleslashline(lex, gmpTense("aorist"), gmpVoice("passive"), kd), " | ",
    participleslashline(lex, gmpTense("aorist"), gmpVoice("passive"), kd, examplecase = gmpCase("genitive")), " |"
    )
    push!(lines, aorpass)


    pftact = string("| Perfect active |",
    participleslashline(lex, gmpTense("perfect"), gmpVoice("active"), kd), " | ",
    participleslashline(lex, gmpTense("perfect"), gmpVoice("active"), kd, examplecase = gmpCase("genitive")), " |"
    )
    push!(lines, pftact)

    pftmid = string("| Perfect middle |",
    participleslashline(lex, gmpTense("perfect"), gmpVoice("middle"), kd), " | ",
    participleslashline(lex, gmpTense("perfect"), gmpVoice("middle"), kd, examplecase = gmpCase("genitive")), " |"
    )
    push!(lines, pftmid)

    pftpass = string("| Perfect passive |",
    participleslashline(lex, gmpTense("perfect"), gmpVoice("passive"), kd), " | ",
    participleslashline(lex, gmpTense("perfect"), gmpVoice("passive"), kd, examplecase = gmpCase("genitive")), " |"
    )
    push!(lines, pftpass)




    futact = string("| Future active |",
    participleslashline(lex, gmpTense("future"), gmpVoice("active"), kd), " | ",
    participleslashline(lex, gmpTense("future"), gmpVoice("active"), kd, examplecase = gmpCase("genitive")), " |"
    )
    push!(lines, futact)

    futmid = string("| Future middle |",
    participleslashline(lex, gmpTense("future"), gmpVoice("middle"), kd), " | ",
    participleslashline(lex, gmpTense("future"), gmpVoice("middle"), kd, examplecase = gmpCase("genitive")), " |"
    )
    push!(lines, futmid)

    futpass = string("| Future passive |",
    participleslashline(lex, gmpTense("future"), gmpVoice("passive"), kd), " | ",
    participleslashline(lex, gmpTense("future"), gmpVoice("passive"), kd, examplecase = gmpCase("genitive")), " |"
    )
    push!(lines, futpass)


    join(lines, "\n")
end