

"""Generate form for a given `Analysis`.

$(SIGNATURES)
"""
function generate(analysis::Analysis, kd::Kanones.Dataset; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    # Find "part of speech" value from formurn:
    formcolumns = split(analysis.form.objectid,"")
    pos = parse(Int64, formcolumns[1])
    
    if pos == NOUN
        println("GEN NOUN")

    elseif pos == UNINFLECTED
        generateuninflected(analysis, kd; ortho = ortho)
        
    else
        println("NOT YET IMPLEMENTED")
    end
end