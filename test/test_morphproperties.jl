@testset "Test GMPTense" begin
    tense = gmpTense("present")
    @test isa(tense, GMPTense)
end

@testset "Test GMPMood" begin
    mood = gmpMood("optative")
    @test isa(mood, GMPMood)
end


@testset "Test GMPVoice" begin
    vc = gmpVoice("middle")
    @test isa(vc, GMPVoice)
end


@testset "Test GMPPerson" begin
    pers = gmpPerson("third")
    @test isa(pers, GMPPerson)
end


@testset "Test GMPNumber" begin
    num = gmpNumber("singular")
    @test isa(num, GMPNumber)
end

@testset "Test GMPGender" begin
    gender = gmpGender("feminine")
    @test isa(gender, GMPGender)
end

@testset "Test GMPDegree" begin
    degree = gmpDegree("superlative")
    @test isa(degree, GMPDegree)
end

@testset "Test GMPUninflectedType" begin
    uninfl = gmpUninflectedType("conjunction")
    @test isa(uninfl, GMPUninflectedType)
end


# degree
# uninflected part of speech
