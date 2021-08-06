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



"""
KanonesIO type for reading and writing data for infinitive rules only.

$(SIGNATURES)

"""
struct InfinitiveRuleParser <: KanonesIO
    label::AbstractString
end


"""
KanonesIO type for reading and writing data for irregular infinitive forms.

$(SIGNATURES)

"""
struct IrregularInfinitiveParser <: KanonesIO
    label::AbstractString
end


"""
KanonesIO type for reading and writing data for participle rules only.

$(SIGNATURES)

"""
struct ParticipleRuleParser <: KanonesIO
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
struct AdjectiveParser <: KanonesIO
    label::AbstractString
end
