
"""Generate a string for the form of a given `Analysis` using a given dataset.
$(SIGNATURES)
"""
function generate(analysis::Analysis, kd::Kanones.Dataset)::Vector{AbstractString}
    # Find "part of speech" value from formurn:
    formcolumns = split(analysis.form.objectid,"")
    pos = parse(Int64, formcolumns[1])
    
    if pos == NOUN
        generatenoun(analysis, kd)
        
    elseif pos == UNINFLECTED
        generateuninflected(analysis, kd)
        
    else
        println("NOT YET IMPLEMENTED")
    end
end

"""Generate a string for a given form and lexeme using a given dataset.
$(SIGNATURES)
"""
function generate(form::FormUrn, lex::LexemeUrn, kd::Kanones.Dataset)::Vector{AbstractString}
    # Find "part of speech" value from formurn:
    formcolumns = split(form.objectid,"")
    pos = parse(Int64, formcolumns[1])
    
    if pos == NOUN
        generatenoun(form, lex, kd)
        
    elseif pos == UNINFLECTED
        #generateuninflected(form, lex, kd)
        println("NOT YET IMPLEMENTED")
    else
        println("NOT YET IMPLEMENTED")
    end
end


"""Remove metadata characters from `s`.

$(SIGNATURES)
"""
function stripmetachars(s)
    replace(s, r"[#_^]" => "")
end