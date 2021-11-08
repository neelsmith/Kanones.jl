#
# Functions to get individual values from a FormUrn
#


"""Extract "part of speech" code from a `FormUrn`.
$SIGNATURES
"""
function poscode(f::FormUrn)::Int64
    parse(Int64, split(f.objectid, "")[1])
end

"""Look up label for "part of speech" code from a `FormUrn`.
$SIGNATURES
"""
function poslabel(f::FormUrn)
    poscode(f) == 0 ? "none" : valuedict(pospairs)[poscode(f)]
end

"""Extract person code from a `FormUrn`.
$SIGNATURES
"""
function personcode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[2])
end

"""Look up label for person code from a `FormUrn`.
$SIGNATURES
"""
function personlabel(f::FormUrn)
    personcode(f) == 0 ? "none" : valuedict(personpairs)[personcode(f)]
end


"""Extract number code from a `FormUrn`.
$SIGNATURES
"""
function numbercode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[3])
end

"""Look up label for number code from a `FormUrn`.
$SIGNATURES
"""
function numberlabel(f::FormUrn)
    numbercode(f) == 0 ? "none" : valuedict(numberpairs)[numbercode(f)]
end


"""Extract tense code from a `FormUrn`.
$SIGNATURES
"""
function tensecode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[4])
end

"""Look up label for tense code from a `FormUrn`.
$SIGNATURES
"""
function tenselabel(f::FormUrn)
    tensecode(f) == 0 ? "none" : label(gmpTense(tensecode(f)))
end


"""Extract mood code from a `FormUrn`.
$SIGNATURES
"""
function moodcode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[5])
end


"""Look up label for mood code from a `FormUrn`.
$SIGNATURES
"""
function moodlabel(f::FormUrn)
    moodcode(f) == 0 ? "none" :  label(gmpMood(moodcode(f)))
end



"""Extract voice code from a `FormUrn`.
$SIGNATURES
"""
function voicecode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[6])
end

"""Look up label for voice code from a `FormUrn`.
$SIGNATURES
"""
function voicelabel(f::FormUrn)
    voicecode(f) == 0 ? "none" :  label(gmpVoice(voicecode(f)))
end


"""Extract gender code from a `FormUrn`.
$SIGNATURES
"""
function gendercode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[7])
end

"""Look up label for gender code from a `FormUrn`.
$SIGNATURES
"""
function genderlabel(f::FormUrn)
    gendercode(f) == 0 ? "none" :  valuedict(genderpairs)[gendercode(f)]
end



"""Extract case code from a `FormUrn`.
$SIGNATURES
"""
function casecode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[8])
end

"""Look up label for case code from a `FormUrn`.
$SIGNATURES
"""
function caselabel(f::FormUrn)
    casecode(f) == 0 ? "none" :  valuedict(casepairs)[casecode(f)]
end



"""Extract case code from a `FormUrn`.
$SIGNATURES
"""
function degreecode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[9])
end


"""Look up label for degree code from a `FormUrn`.
$SIGNATURES
"""
function degreelabel(f::FormUrn)
    degreecode(f) == 0 ? "none" :  valuedict(degreepairs)[degreecode(f)]
end


"""Extract case code from a `FormUrn`.
$SIGNATURES
"""
function uninflectedcode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[10])
end



"""Look up label for uninflected code from a `FormUrn`.
$SIGNATURES
"""
function uninflectedlabel(f::FormUrn)
    uninflectedcode(f) == 0 ? "none" :  valuedict(uninflectedpairs)[uninflectedcode(f)]
end

# PosPNTMVGCDCat
