"""
Implementations of this type can read delimited and write fst.

$(SIGNATURES)
"""
abstract type KanonesIO end

"""
KanonesIO type for reading and writing stem for uninflected forms.
$(SIGNATURES)
"""
struct UninflectedParser <: KanonesIO
    label::AbstractString
end

"""
KanonesIO type for reading and writing data for noun forms.

$(SIGNATURES)
"""
struct NounParser <: KanonesIO
    label::AbstractString
end

"""
KanonesIO type for reading and writing data for irregular noun forms.

$(SIGNATURES)
"""
struct IrregularNounParser <: KanonesIO
    label::AbstractString
end



"""
KanonesIO type for reading and writing data for irregular rules only.

$(SIGNATURES)

Individual irregular types must have separate parsers for stems.
"""
struct IrregularRuleParser <: KanonesIO
    label::AbstractString
end

"""
KanonesIO type for reading and writing data for finite verb form.

$(SIGNATURES)
"""    
struct VerbParser <: KanonesIO
    label::AbstractString
end

"""
KanonesIO type for reading and writing data for irregular finite verb forms.

$(SIGNATURES)
"""
struct IrregularVerbParser <: KanonesIO
    label::AbstractString
end