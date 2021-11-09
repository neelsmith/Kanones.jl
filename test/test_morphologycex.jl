


@testset "Test composition of complete CEX for all uninflected forms" begin
    gmfUninflecteds = split(Kanones.uninflectedcex(), "\n")
    @test length(gmfUninflecteds) == 6
end


@testset "Test composition of CEX for uninflected form" begin
    uform = GMFUninflected(GMPUninflectedType(1))
    @test_broken Kanones.cex(uform) == "urn:cite2:kanones:morphforms.v1:1000000001|uninflected form: conjunction"
end


@testset "Test composition of complete CEX for all noun forms" begin
    gmfNouns = ""# BROKEN split(Kanones.nounscex(), "\n")
    # 3 gender * 3 number * 5 cases = 45
    @test_broken length(gmfNouns) == 45
end


@testset "Test compostion of CEX for noun form" begin
    noun = GMFNoun(GMPGender(1), GMPCase(1), GMPNumber(1) )

    #println("\n\n",Kanones.cex(noun),"\n\n")
    @test_broken Kanones.cex(noun) == "urn:cite2:kanones:morphforms.v1:1000000001|uninflected form: conjunction"
end
