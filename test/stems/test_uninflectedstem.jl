
@testset "Test IO for delimited text of uninflected stems" begin
    delimited = "uninflectedstems.n51951|lsj.n51951|καί|conjunction|"
    uninflio = Kanones.UninflectedIO("IO for uninfls")
    stem = Kanones.readstemrow(uninflio, delimited)
    @test stem isa UninflectedStem
    @test Unicode.normalize(cex(stem)) == Unicode.normalize("uninflectedstems.n51951|Uninflected conjunction καί|καί|lsj.n51951|conjunction")


end


@testset "Test data accessors for uninflected stems" begin
    delimited = "uninflectedstems.n51951|lsj.n51951|καί|conjunction|"
    uninflio = Kanones.UninflectedIO("IO for uninfls")
    stem = Kanones.readstemrow(uninflio, delimited)
    expectedurn = StemUrn("uninflectedstems.n51951")
    @test urn(stem) == expectedurn

    dict = Dict("uninflectedstems" => "urn:cite2:kanones:uninflectedstems.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:uninflectedstems.v1:n51951")
    @test urn(stem) == expectedurn
    @test urn(stem, registry = dict) == expectedcite2


    @test lexemeurn(stem) == LexemeUrn("lsj.n51951")
    @test Unicode.normalize(stemstring(stem)) == Unicode.normalize(s"καί")

    @test code(stem) == "1000000001"
    @test Kanones.formurn(stem) == FormUrn("forms.1000000001")
    
end

