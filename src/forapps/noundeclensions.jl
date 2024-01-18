"""Decline all case-number combinations of `lex`, a noun.
$(SIGNATURES)
"""
function decline(lex::LexemeUrn, kd::Kanones.FilesDataset; withvocative::Bool = false)
    stemmatches = filter(s -> lexeme(s) == lex, stemsarray(kd))
    @debug("decline: found $(length(stemmatches)) stems for $(lex)")
    declinedforms = []
    
    for stem in stemmatches
        # Handle stem differently if is irregular!
        if inflectionclass(stem) == "irregularnoun"
            @debug("Handle irregular noun with $(length(stemmatches)) stems")
            generated = generate(lex, formurn(stem), kd) 
            if !isempty(generated)
                push!(declinedforms, generated[1])
            end
        else
            @debug("Handle regular noun")
            forms = filter(f -> gmpGender(f) == gmpGender(stem), Kanones.nounforms())
            rules = filter(r -> inflectionclass(r) == inflectionclass(stem), rulesarray(kd))    
            for f in forms
                rulematches = filter(r -> formurn(r) == formurn(f), rules) 
                if !isempty(rulematches)
                    push!(declinedforms, generate(stem, rulematches[1]))
                end
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
    if length(arry) > 4
        for i in 1:5
            push!(lines, string("| **", labels[i], "** | ", arry[i], " | ", arry[i + 5], " |"))
        end
    else
        @warn("Only able to decline $(length(arry)) forms for $(lex)")
    end
    join(lines,"\n")
end



"""Compose markdown for a dictionary entry for a single noun,
$(SIGNATURES)
"""
function lexicon_noun_md(lex::LexemeUrn, kd::Kanones.FilesDataset)
    
    # 1.
    stemdata = filter(stemsarray(kd)) do stem
        stem.lexid == lex
    end
    genderlist = map(stem -> Kanones.gender(stem), stemdata) |> unique
    #gender = join(genderlist, ", or ")
    noms = []
    gens = []
    
    if isempty(genderlist)
        @warn("No gender found for lexeme $(lex)!")
        throw(ArgumentError("lexicon_noun_md: bad data, no gender found for $(lex)"))
    else
        for g in genderlist
            if isnothing(g)
                @warn("No gender found for lexeme $(lex)!")
                throw(ArgumentError("lexicon_noun_md: bad data, no gender found for $(lex)"))
            end
        end
    end
     
    # 2.
    noms_form = GMFNoun(genderlist[1], gmpCase("nominative"), gmpNumber("singular")) |> formurn
    push!(noms,generate(lex, noms_form, kd))
    # 3.
    gens_form = GMFNoun(genderlist[1], gmpCase("genitive"), gmpNumber("singular")) |> formurn
    push!(gens, generate(lex, gens_form, kd))
        
    

    nomforms = Iterators.flatten(noms) |> collect |> unique
    genforms = Iterators.flatten(gens) |> collect |> unique
    if isempty(noms) || isempty(gens)
        @warn("lexicon_noun_md: could not generate nominative and genitive singular for $(lex)")
        ""
    else


        genderstrings = map(g -> label(g)[1] * ".", filter(g -> ! isnothing(g), genderlist))
        string(join(nomforms, " or "), ", ", join(genforms, " or "), ", *", join(genderstrings, " or "), "*")
    end
end


"""Find gender property for a Kanones stem.
Returns `nothing` if stem does not have a gender property.
$(SIGNATURES)
"""
function gender(stem::T) where {T <: KanonesStem}
    if stem isa IrregularNounStem
        stem.noungender
    elseif stem isa NounStem
        stem.gender
    else
        nothing
    end
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