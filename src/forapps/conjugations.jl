
function conjugation()
end

function md_conjugation(t::GMPTense, v::GMPVoice, lex::LexemeUrn, kd::Kanones.FilesDataset)
    tenseforms = filter(f -> gmpTense(f) == t && gmpVoice(f) == v, verbforms())
   
 
    mdlines = ["| | Indicative | Subjunctive | Optative |",   
    "| --- | --- | --- | --- |"]
    
    # SINGULAR:
    indic_forms = filter(f -> gmpMood(f) == gmpMood("indicative") && gmpNumber(f) == gmpNumber("singular"), tenseforms)
   

    
    indic_tokens = map(f -> generate(lex, formurn(f), kd), indic_forms)
    indic_labels = map(v -> join(v, ", "), indic_tokens)
   
    

    subj_forms = filter(f -> gmpMood(f) == gmpMood("subjunctive") && gmpNumber(f) == gmpNumber("singular"), tenseforms)
    subj_tokens = map(f -> generate(lex, formurn(f), kd), subj_forms)
    subj_labels = map(v -> join(v, ", "), subj_tokens)
    if isempty(subj_labels)
        subj_labels = ["-","-","-"]
    end

    opt_forms = filter(f -> gmpMood(f) == gmpMood("optative") && gmpNumber(f) == gmpNumber("singular"), tenseforms)
    opt_tokens = map(f -> generate(lex, formurn(f), kd), opt_forms)
    opt_labels = map(v -> join(v, ", "), opt_tokens)
    if isempty(opt_labels)
        opt_labels = ["-","-","-"]
    end
    for i in 1:3
        push!(mdlines, "| **$(personlabeldict[i]) singular** | $(indic_labels[i]) | $(subj_labels[i]) | $(opt_labels[i]) |")
    end

    # PASSIVE:
    indicpl_forms = filter(f -> gmpMood(f) == gmpMood("indicative") && gmpNumber(f) == gmpNumber("plural"), tenseforms)
    indicpl_tokens = map(f -> generate(lex, formurn(f), kd), indicpl_forms)
    indicpl_labels = map(v -> join(v, ", "), indicpl_tokens)

    subjpl_forms = filter(f -> gmpMood(f) == gmpMood("subjunctive") && gmpNumber(f) == gmpNumber("plural"), tenseforms)
    subjpl_tokens = map(f -> generate(lex, formurn(f), kd), subjpl_forms)
    subjpl_labels = map(v -> join(v, ", "), subjpl_tokens)
    if isempty(subjpl_labels)
        subjpl_labels = ["-","-","-"]
    end

    optpl_forms = filter(f -> gmpMood(f) == gmpMood("optative") && gmpNumber(f) == gmpNumber("plural"), tenseforms)
    optpl_tokens = map(f -> generate(lex, formurn(f), kd), optpl_forms)
    optpl_labels = map(v -> join(v, ", "), optpl_tokens)
    if isempty(optpl_labels)
        optpl_labels = ["-","-","-"]
    end

    for i in 1:3
        push!(mdlines, "| **$(personlabeldict[i]) plural** | $(indicpl_labels[i]) | $(subjpl_labels[i]) | $(optpl_labels[i]) |")
    end
    join(mdlines, "\n")
end


"""Compose markdown table with imperative conjugation of `lex`.
$(SIGNATURES)
"""
function md_imperativeconjugation(t::GMPTense, v::GMPVoice, lex::LexemeUrn, kd::Kanones.FilesDataset)
    mdlines = ["| | Singular | Plural|",   
    "| --- | --- | --- |"]
    imptvforms = filter(f -> f isa GMFFiniteVerb && gmpMood(f) == gmpMood("imperative"), allforms())

    singforms = filter(f -> gmpNumber(f) == gmpNumber(1) && gmpTense(f) == t && gmpVoice(f) == v,imptvforms)
    generatedsing = []
    for f in singforms
        frmstring = join(generate(lex, formurn(f), kd),", ")
        push!(generatedsing, frmstring)
    end

    
    plforms = filter(f -> gmpNumber(f) == gmpNumber("plural") && gmpTense(f) == t && gmpVoice(f) == v,imptvforms)
    generatedpl = []
    for f in plforms
        frmstring = join(generate(lex, formurn(f), kd),", ")
        push!(generatedpl,frmstring)
    end
    
     

    #pllabels = plforms .|> label

    for i in 1:2
        push!(mdlines, "| **$(personlabeldict[i + 1])** | $(generatedsing[i]) | $(generatedpl[i])  |")
    end
    join(mdlines,"\n")
end





"""Write conjugation table for `lex` to a file.
$(SIGNATURES)
"""
function proofconjugation(lex::LexemeUrn, kds::T, f = "scratch/proofconjugation.md") where {T <: Kanones.Dataset}


    presfinites = "# Present tense\n\n*Active*\n\n" * md_conjugation(gmpTense("present"), gmpVoice("active"), lex, kds) * "\n\n*Middle/passive*\n\n"  *  md_conjugation(gmpTense("present"), gmpVoice("passive"), lex, kds)

    presimp = "## Imperative\n\n*Active*\n\n" * md_imperativeconjugation(gmpTense("present"), gmpVoice("active"), lex, kds) * "\n\n*Middle/passive*\n\n" * md_imperativeconjugation(gmpTense("present"), gmpVoice("passive"), lex, kds)
    
    vadj = GMFVerbalAdjective(
    gmpGender("neuter"), gmpCase("nominative"), gmpNumber(1))
    vadjforms = generate(lex, formurn(vadj), kds)
    vadjtoken = isempty(vadjforms) ? ""  : vadjforms[1]

    inf_act = GMFInfinitive(
        gmpTense("present"), gmpVoice("active")
    )
    inf_actforms = generate(lex, formurn(inf_act), kds)
    inf_acttoken = isempty(inf_actforms) ? ""  : inf_actforms[1]


    inf_pass = GMFInfinitive(
        gmpTense("present"), gmpVoice("passive")
    )
    inf_passforms = generate(lex, formurn(inf_pass), kds)
    inf_passtoken = isempty(inf_passforms) ? ""  : inf_passforms[1]

    actptcpl = participleslashline(lex, gmpTense("present"), gmpVoice("active"), kds)
    

    mpptcpl = participleslashline(lex, gmpTense("present"), gmpVoice("middle"), kds)


    actptcitem = "- **Active participle**: $(actptcpl)"
    mpptcplitem = "- **Middle/passive participle**: $(mpptcpl)"
    infaitem = "- **Active infinitive**: $(inf_acttoken)"
    infpitem = "- **Passive infinitive**: $(inf_passtoken)"
    vadjitem = "- **Verbal adjective**: $(vadjtoken)"

    presnominal = join([actptcitem, mpptcplitem,infaitem, infpitem, vadjitem], "\n")


# ### Imperfect tense


    impftact = "\n\n## Imperfect\n\n*Active*\n\n" * md_conjugation(gmpTense("imperfect"), gmpVoice("active"), lex, kds)
    impftmp = "\n\n*Middle/passive*\n\n" * md_conjugation(gmpTense("imperfect"), gmpVoice("passive"), lex, kds)
    
    futfinites = "\n\n# Future tense\n\n*Active*\n\n" * md_conjugation(gmpTense("future"), gmpVoice("active"), lex, kds) * "\n\n*Middle*\n\n"  *  md_conjugation(gmpTense("future"), gmpVoice("middle"), lex, kds) * "\n\n*Passive*\n\n" * md_conjugation(gmpTense("future"), gmpVoice("passive"), lex, kds)



    pieces = [
        presfinites, presimp, presnominal, 
        impftact, impftmp,
        futfinites
    ]

    md = join(pieces, "\n\n")
    open(f,"w") do io
        write(io, md)
    end

#=







```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
lex = LexemeUrn("lsj.n56496")



inf_act = GMFInfinitive(
    gmpTense("future"), gmpVoice("active")
)
inf_actforms = generate(lex, formurn(inf_act), kds)


inf_mdl = GMFInfinitive(
    gmpTense("future"), gmpVoice("middle")
)
inf_mdlforms = generate(lex, formurn(inf_mdl), kds)


inf_pass = GMFInfinitive(
    gmpTense("future"), gmpVoice("passive")
)
inf_passforms = generate(lex, formurn(inf_pass), kds)


actptcpl = participleslashline(lex, gmpTense("future"), gmpVoice("active"), kds)

midptcpl = participleslashline(lex, gmpTense("future"), gmpVoice("middle"), kds)

passptcpl = participleslashline(lex, gmpTense("future"), gmpVoice("passive"), kds)

mdlines = [
    "- **active infinitive**: $(inf_actforms[1])",
    "- **middle infinitive**: $(inf_mdlforms[1])",
    "- **passive infinitive**: $(inf_passforms[1])",
    "- **active participle**: $(actptcpl)",
    "- **middle participle**: $(midptcpl)",
    "- **passive participle**: $(passptcpl)"
]
Markdown.parse(join(mdlines,"\n"))
```




## Aorist tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
lex = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("active"), lex, kds))
```


*Middle voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
lex = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("middle"), lex, kds))
```


*Passive voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
lex = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("passive"), lex, kds))
```




### Imperative 

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
lex = LexemeUrn("lsj.n56496")

tbl = md_imperativeconjugation(gmpTense("aorist"), gmpVoice("active"), lex, kds)
Markdown.parse(tbl)
```


*Middle voice*:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
lex = LexemeUrn("lsj.n56496")

tbl = md_imperativeconjugation(gmpTense("aorist"), gmpVoice("middle"), lex, kds)
Markdown.parse(tbl)
```



*Passive voice*:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
lex = LexemeUrn("lsj.n56496")

tbl = md_imperativeconjugation(gmpTense("aorist"), gmpVoice("passive"), lex, kds)
Markdown.parse(tbl)
```



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
lex = LexemeUrn("lsj.n56496")



inf_act = GMFInfinitive(
    gmpTense("aorist"), gmpVoice("active")
)
inf_actforms = generate(lex, formurn(inf_act), kds)


inf_mdl = GMFInfinitive(
    gmpTense("aorist"), gmpVoice("middle")
)
inf_mdlforms = generate(lex, formurn(inf_mdl), kds)


inf_pass = GMFInfinitive(
    gmpTense("aorist"), gmpVoice("passive")
)
inf_passforms = generate(lex, formurn(inf_pass), kds)



actptcpl = participleslashline(lex, gmpTense("aorist"), gmpVoice("active"), kds)

midptcpl = participleslashline(lex, gmpTense("aorist"), gmpVoice("middle"), kds)

passptcpl = participleslashline(lex, gmpTense("aorist"), gmpVoice("passive"), kds)


mdlines = [
    "- **active infinitive**: $(inf_actforms[1])",
    "- **middle infinitive**: $(inf_mdlforms[1])",
    "- **passive infinitive**: $(inf_passforms[1])",
    "- **active participle**: $(actptcpl)",
    "- **middle participle**: $(midptcpl)",
    "- **passive participle**: $(passptcpl)"
]

Markdown.parse(join(mdlines,"\n"))

```




## Perfect system

### Perfect tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
lex = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("perfect"), gmpVoice("active"), lex, kds))
```




*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
lex = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("perfect"), gmpVoice("passive"), lex, kds))
```



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
lex = LexemeUrn("lsj.n56496")

actptcpl = participleslashline(lex, gmpTense("perfect"), gmpVoice("active"), kds)

mpptcpl = participleslashline(lex, gmpTense("perfect"), gmpVoice("middle"), kds)


inf_act = GMFInfinitive(
    gmpTense("perfect"), gmpVoice("active")
)
inf_actforms = generate(lex, formurn(inf_act), kds)

mdlines = [
    "- **active infinitive**: $(inf_actforms[1])",
    "- **active participle**: $(actptcpl)",
    "- **middle & passive participle**: $(mpptcpl)"
]
Markdown.parse(join(mdlines,"\n"))
```

### Pluperfect tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
lex = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("pluperfect"), gmpVoice("active"), lex, kds))
```



*Middle and passive voices* (identical forms):

```@eval







Markdown.parse(md_conjugation(gmpTense("pluperfect"), gmpVoice("passive"), lex, kds))
```
    =#
  
end