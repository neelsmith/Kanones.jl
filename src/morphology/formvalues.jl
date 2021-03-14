"""Create a dictionary keyed by the value of a label-value pair."""
function valuedict(prs)
    dict = Dict()
    for pr in prs
        push!(dict, pr[1] => pr[2])
    end
    dict
end

"""Create a dictionary keyed by the label of a label-value pair."""
function labeldict(prs)
    dict = Dict()
    for pr in prs
        push!(dict, pr[2] => pr[1])
    end
    dict
end


"""Constants for analytical types ("parts of speech")."""
const pospairs = [
    (UNANALYZED, "unanalyzed"),
    (UNINFLECTED, "uninflected"),
    (NOUN, "noun"),
    (FINITEVERB, "verb-finite")
]
#  <conjunction><particle><interjection><preposition><adverb><numeral>


"""Constants for persons."""
const personpairs = [
    (1, "first"),
    (2, "second"),
    (3, "third")
]

"""Constants for number."""
const numberpairs = [
    (1, "singular"),
    (2, "dual"),
    (3, "plural")
]

"""Constants for voice."""
const voicepairs = [
    (1, "present"),
    (2, "imperfect"),
    (3, "future"),
    (4, "aorist"),
    (5, "perfect"),
    (6, "pluperfect"),
]

"""Constants for tense."""
const tensepairs = [
    (1, "present"),
    (2, "imperfect"),
    (3, "future"),
    (4, "aorist"),
    (4, "perfect"),
    (4, "pluperfect")
]

"""Constants for mood."""
const moodpairs = [
    (1, "indicative"),
    (2, "subjunctive"),
    (3, "optative"),
    (4, "imperative")
]


"""Values for uninflected type in URN for uninflected form."""
const uninflectedpairs = [
    (1, "conjunction"),
    (2, "preposition"),
    (3, "particle"),
    (4, "adverb"),
    (5, "numeral"),
    (6, "interjection")
]