"""Decline all case-number combinations of `lex`, a noun.
$(SIGNATURES)
"""
function  decline(lex::LexemeUrn, kd::Kanones.FilesDataset; withvocative::Bool = false)
    stemmatches = filter(s -> lexeme(s) == lex, stemsarray(kd))
    
    declinedforms = []
    for stem in stemmatches
        forms = filter(f -> gmpGender(f) == gmpGender(stem), Kanones.nounforms())
        rules = filter(r -> inflectionclass(r) == inflectionclass(stem), rulesarray(kd))    
        for f in forms
            rulematches = filter(r -> formurn(r) == formurn(f), rules) 
            if !isempty(rulematches)
                push!(declinedforms, generate(stem, rulematches[1]))
            end
        end
    end
    declinedforms
end


"""Compose markdown table with a declension of a single noun.

$(SIGNATURES)
"""
function declension_md(lex::LexemeUrn, kd::Kanones.FilesDataset)
    labels = ["nominative", "genitive", "dative", "accusative", "vocative"]
    lines = [
        "| | Singular | Plural |", 
        "| --- | --- | --- |"
    ]

    arry = decline(lex, kd)
    for i in 1:5
        push!(lines, string("| **", labels[i], "** | ", arry[i], " | ", arry[i + 5], " |"))
    end
    join(lines,"\n")
end

#=
"""Compose markdown table with aligned declensions of multiple nouns.

$(SIGNATURES)
"""
function declension_md(lexlist::Array, kd::Kanones.FilesDataset; withvocative::Bool = false)
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
function genders(lexlist, kd::Kanones.FilesDataset)
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
function stemtypes(lexlist::Array, kd::Kanones.FilesDataset)
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
=#