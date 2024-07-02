"""
Implementations of this type can read and write delimited text formatting of Kanones morphological data.

$(SIGNATURES)
"""
abstract type KanonesIO end

"""
KanonesIO type for reading and writing stem for uninflected forms.
$(SIGNATURES)
"""
struct UninflectedIO <: KanonesIO
    label::AbstractString
end

"""
KanonesIO type for reading and writing data for irregular noun forms.

$(SIGNATURES)
"""
struct IrregularNounIO <: KanonesIO
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
KanonesIO type for reading and writing data for irregular finite verb forms.

$(SIGNATURES)
"""
struct IrregularVerbIO <: KanonesIO
    label::AbstractString
end



"""
KanonesIO type for reading and writing data for infinitive rules only.

$(SIGNATURES)

"""
struct InfinitiveIO <: KanonesIO
    label::AbstractString
end


"""
KanonesIO type for reading and writing data for irregular infinitive forms.

$(SIGNATURES)

"""
struct IrregularInfinitiveIO <: KanonesIO
    label::AbstractString
end


"""
KanonesIO type for reading and writing data for participle rules only.

$(SIGNATURES)

"""
struct ParticipleIO <: KanonesIO
    label::AbstractString
end



"""
KanonesIO type for reading and writing data for irregular participial forms.

$(SIGNATURES)

"""
struct IrregularParticipleIO <: KanonesIO
    label::AbstractString
end


"""
KanonesIO type for reading and writing data for irregular noun forms.

$(SIGNATURES)
"""
struct IrregularAdjectiveIO <: KanonesIO
    label::AbstractString
end