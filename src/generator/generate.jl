

"""Generate form for a given `Analysis`.
$(SIGNATURES)
"""
function generate(analysis::Analysis, kd::Kanones.Dataset)
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
