
"""Decline all case-number combinations of a lexeme.

$(SIGNATURES)
"""
function decline(lex::LexemeUrn, kd::Kanones.Dataset; withvocative::Bool = false)
    stems = stemsarray(kd)
    nounstems = filter(s -> typeof(s) == NounStem, stems)
    stemmatches = filter(s -> s.lexid == lex, nounstems)
    
    # Make sure stemmatches is not empty first:
    if isempty(stemmatches)
        @warn "No matches in dataset for lexeme $lex"
        nothing

    else
        gender = stemmatches[1].gender
        # Find gender and construct form ids:
        genderint = Kanones.code(gender)


        sg = [
            FormUrn("$(COLLECTION_ID).201000$(genderint)100"),
            FormUrn("$(COLLECTION_ID).201000$(genderint)200"),
            FormUrn("$(COLLECTION_ID).201000$(genderint)300"),
            FormUrn("$(COLLECTION_ID).201000$(genderint)400")
        ]
        # No duals by default
        pl = [
            FormUrn("$(COLLECTION_ID).203000$(genderint)100"),
            FormUrn("$(COLLECTION_ID).203000$(genderint)200"),
            FormUrn("$(COLLECTION_ID).203000$(genderint)300"),
            FormUrn("$(COLLECTION_ID).203000$(genderint)400")
        ]

        rules = rulesarray(kd)
        nounrules = filter(r -> typeof(r) == NounRule, rules)

        forms = []
        for srule in sg
            push!(forms, generate(srule,lex,  kd))
        end
        for plrule in pl
            push!(forms, generate(plrule, lex, kd))
        end
        forms
    end
end

"""Compose markdown table with a declension of a single noun.

$(SIGNATURES)
"""
function mddeclension(lex::LexemeUrn, kd::Kanones.Dataset; withvocative::Bool = false)
    labels = ["nominative", "genitive", "dative", "accusative"]
    lines = ["| | Singular | Plural |", "| --- | --- | --- |"]
    arry = decline(lex, kd;  withvocative = withvocative)
    for i in 1:4
        push!(lines, string("| **", labels[i], "** | ", join(arry[i], ", "), " | ", join(arry[i + 4], ", "), " |"))
    end
    join(lines,"\n")
end

"""Compose markdown table with aligned declensions of multiple nouns.

$(SIGNATURES)
"""
function mddeclension(lexlist::Array, kd::Kanones.Dataset; withvocative::Bool = false)
    labels = ["nominative", "genitive", "dative", "accusative"]
    gendervalues = genders(lexlist, kd)
    inflclasses = stemtypes(lexlist, kd)

    hdr = "| | "
    for i in 1:length(lexlist)
        hdr = hdr * string("`", inflclasses[i], "` |")
    end
    lines = [
        "**Singular**",
        "",
        hdr,
        "| --- | " * repeat( " :--- |", length(lexlist))
    ]
    
    for y in 1:length(labels)
        row =  string("| **", labels[y], "** | ")   
        for x in 1:length(lexlist)
            form = FormUrn("$(COLLECTION_ID).201000$(gendervalues[x])$(y)00")
            surface = generatenoun( form, lexlist[x], kd)
            row = row * string(join(surface, ", "),  " | ")

        end
        push!(lines, row)
    end
    push!(lines,"")
    push!(lines,"**Plural**")
    push!(lines, "")


    hdr2 = "| | "
    for i in 1:length(lexlist)
        hdr2 = hdr2 * string(" |")
    end
    push!(lines, hdr2)
    push!(lines, "| --- | " * repeat( " :--- |", length(lexlist)))
    for y in 1:length(labels)
        row =  string("| **", labels[y], "** | ")   
        for x in 1:length(lexlist)
            form = FormUrn("$(COLLECTION_ID).203000$(gendervalues[x])$(y)00")
            surface = generatenoun( form, lexlist[x], kd)
            row = row * string(join(surface, ", "),  " | ")
        end
        push!(lines, row)
    end

    join(lines, "\n")
end
 

"""Look up integer code for gender for a list of nouns.

$(SIGNATURES)
"""
function genders(lexlist, kd::Kanones.Dataset)
    stems = stemsarray(kd)
    nounstems = filter(s -> typeof(s) == NounStem, stems)

    genderlist = []
    for lex in lexlist
        stemmatches = filter(s -> s.lexid == lex, nounstems)
        if isempty(stemmatches)
            @warn "No matches in dataset for lexeme $lex"
            push!(genderlist, nothing)
    
        else
            push!(genderlist, code(gmpGender(stemmatches[1])))
        end
    end
    genderlist
end



"""Look up integer code for gender for a list of nouns.

$(SIGNATURES)
"""
function stemtypes(lexlist::Array, kd::Kanones.Dataset)
    stems = stemsarray(kd)
    nounstems = filter(s -> typeof(s) == NounStem, stems)

    stemtypes = []
    for lex in lexlist
        stemmatches = filter(s -> s.lexid == lex, nounstems)
        if isempty(stemmatches)
            @warn "No matches in dataset for lexeme $lex"
            push!(stemtypes, nothing)
    
        else
            push!(stemtypes, stemmatches[1].inflectionclass)
        end
    end
    stemtypes
end