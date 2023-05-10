@testset "Test constructor and constructor functions" begin
    # True constructor from morphological properties
    adj = GMFAdjective(gmpGender("feminine"), gmpCase("accusative"), gmpNumber("plural"), gmpDegree("positive"))   
    
    # Constructor functions: 
    # round-trip a Cite2Urn
    adjurn =  urn(adj)
    expected = Cite2Urn("urn:cite2:kanones:forms.v1:7030002410")
    @test adjurn == expected
    @test adj == gmfAdjective(adjurn)

    # round-trip a FormUrn
    abbrurn = Kanones.formurn(adj)
    expectedabbr = FormUrn("forms.7030002410")
    @test abbrurn == expectedabbr
    @test adj == gmfAdjective(abbrurn)

    # round-trip a digital code
    adjcode = code(adj)
    expectedcode = "7030002410"
    @test adjcode == expectedcode
    @test adj == gmfAdjective(adjcode)
end

@testset "Test property accessors and labelling" begin
    adj = GMFAdjective(gmpGender("feminine"), gmpCase("accusative"), gmpNumber("plural"), gmpDegree("positive"))   
    @test label(gmpGender(adj)) == "feminine"
    @test label(gmpCase(adj)) == "accusative"
    @test label(gmpNumber(adj)) == "plural"
    @test label(gmpDegree(adj)) == "positive"

    @test label(adj) == "adjective:  feminine accusative plural positive"
end
