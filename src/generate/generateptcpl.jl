function participleaccent(f::GMFParticiple)

end

"""Generate a form for a given adjective stem and rule by combining
stem and ending, then adding appropriate accent for this lexical
item in this form, and finally stripping off metadata characters
marking vowel quantity and morpheme boundaries.
$(SIGNATURES)
"""
function generate(
    stem::VerbStem, 
    rule::ParticipleRule;           
    ortho::GreekOrthography = literaryGreek())

    stembase = stemstring(stem)
    if regularverbclass(stem)
        stembase = principalpart(stem, rule, ortho = ortho)
        @debug("Figured stembase from stem", stembase,stem)
    end
    raw = stembase * ending(rule)
    if countaccents(raw, ortho) == 1
        # Already has accent! 
        stripmetachars(raw)  |> knormal

    else
        accentpattern = participleaccent(greekForm(rule))
        @debug("Figure out participle accent")
        if isnothing(raw)
            throw(DomainError("EMPTY STRING from stem/rule $(stem)/$(rule)"))
        end
        stripmetachars(accentword(raw, :RECESSIVE, ortho))  |> knormal
        #=
        try
            if stem.accentpersistence == "recessive"
                stripmetachars(accentword(raw, :RECESSIVE, ortho))
            
            elseif stem.accentpersistence == "stemaccented"
                stripmetachars( accentword(raw, :PENULT, ortho))
            
            else 
                # place correct accent on ultima:
                @debug("ACC.ULTIMA:", raw)
                caselabel = label(gmpCase(rule))   
                if caselabel == "genitive" || caselabel == "dative"
                    stripmetachars(accentultima(raw, :CIRCUMFLEX, ortho))
                    
                else
                    stripmetachars(accentultima(raw, :ACUTE, ortho))
                    
                end
            end
         
        catch e
            @warn("Failed to create accented form", e)
            @warn("Raw word: $(raw)")

        end   =#
    end
end





"""Generate list of codes for all participle forms.
$(SIGNATURES)
"""
function participleformcodes()
    genderints = keys(genderlabeldict) |> collect |> sort
    caseints = keys(caselabeldict) |> collect |> sort
    numints = keys(numberlabeldict) |> collect |> sort
    tenseints = [tensecodedict["present"],
        tensecodedict["future"],
        tensecodedict["aorist"],
        tensecodedict["perfect"]
    ]
    voiceints = keys(voicelabeldict) |> collect |> sort
    formlist = []
    for t in tenseints
        for v in voiceints
            
            for n in numints
                for g in genderints
                    for c in caseints
                        push!(formlist, "$(PARTICIPLE)0$(n)$(t)0$(v)$(g)$(c)00")
                    end
                end
            end
           
        end
    end
    formlist
end

"""Generate list of all possible adjective forms.
$(SIGNATURES)
"""
function participleforms()
    participleformcodes() .|> gmfParticiple
end
