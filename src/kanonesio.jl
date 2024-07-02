"""
Implementations of this type can read and write delimited text formatting of Kanones morphological data.

$(SIGNATURES)
"""
abstract type KanonesIO end


"""
KanonesIO type for reading and writing data for irregular rules only.

$(SIGNATURES)

Individual irregular types must have separate parsers for stems.
"""
struct IrregularRuleParser <: KanonesIO
    label::AbstractString
end







"""
KanonesIO type for reading and writing data for irregular noun forms.

$(SIGNATURES)
"""
struct IrregularAdjectiveIO <: KanonesIO
    label::AbstractString
end