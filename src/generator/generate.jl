

"""Generate form for a given `Analysis`.

$(SIGNATURES)
"""
function generate(analysis::Analysis; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    # Find "part of speech" value from formurn:
    formcolumns = split(analysis.form.objectid,"")
    pos = parse(Int64, formcolumns[1])
    
    if pos == NOUN
        println("GEN NOUN")
    elseif posint == UNINFLECTED
        pritnln("GEN UNINFL")
    else
        println("NOT YET IMPLEMENTED")
    end
end