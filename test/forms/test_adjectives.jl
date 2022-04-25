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
    abbrurn = formurn(adj)
    

end
