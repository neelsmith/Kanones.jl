"""
Implementations of this type can read delimited text and write SFST.

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
KanonesIO type for reading and writing data for regular noun forms.

$(SIGNATURES)
"""
struct NounIO <: KanonesIO
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
KanonesIO type for reading and writing data for pronoun forms.

$(SIGNATURES)
"""
struct PronounIO <: KanonesIO
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
struct IrregularParticipleParser <: KanonesIO
    label::AbstractString
end



"""
KanonesIO type for reading and writing data for verbal adjective rules only.

$(SIGNATURES)

"""
struct VerbalAdjectiveRuleParser <: KanonesIO
    label::AbstractString
end



"""
KanonesIO type for reading and writing data for adjective rules and stems.

$(SIGNATURES)
"""
struct AdjectiveIO <: KanonesIO
    label::AbstractString
end

"""
KanonesIO type for reading and writing data for irregular noun forms.

$(SIGNATURES)
"""
struct IrregularAdjectiveIO <: KanonesIO
    label::AbstractString
end