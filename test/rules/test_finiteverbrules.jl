@testset "Test IO with delimited text" begin
    delimited = "verbinfl.numipres8|numi|νυσαι|second|singular|present|indicative|middle|"
    verbio = Kanones.VerbIO("IO for verbs")
    rule = Kanones.readrulerow(verbio, delimited)
    # must read from delimited
    @test rule isa FiniteVerbRule
    # must write to delimited
   @test Unicode.normalize(cex(rule)) == Unicode.normalize("verbinfl.numipres8|Verb inflection rule: ending -νυσαι in class numi can be present indicative middle second singular.|νυσαι|numi|forms.3211120000")
end



@testset "Test data accessors" begin
    delimited = "verbinfl.numipres8|numi|νυσαι|second|singular|present|indicative|middle|"
    verbio = Kanones.VerbIO("IO for verbs")
    rule = Kanones.readrulerow(verbio, delimited)

    # must get id
    ruleu = Kanones.ruleurn(rule)
    expectedurn = RuleUrn("verbinfl.numipres8")
    @test ruleu == expectedurn


    dict = Dict("verbinfl" => "urn:cite2:kanones:verbinfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:verbinfl.v1:numipres8")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2


    # must get infltype and ending
    @test inflectionClass(rule) == "numi"
    @test ending(rule) == "νυσαι"

    # morphological data
    formabbr = formurn(rule)
    expectedabbr = FormUrn("forms.3211120000")
    @test formabbr == expectedabbr

    formcode = code(rule)
    expectedcode = "3211120000"
    @test formcode == expectedcode
end

