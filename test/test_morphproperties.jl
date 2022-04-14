@testset ExtendedTestSet "Test GMPTense" begin
    tense = gmpTense("present")
    @test isa(tense, GMPTense)
end

@testset ExtendedTestSet "Test GMPMood" begin
    mood = gmpMood("optative")
    @test isa(mood, GMPMood)
end


@testset ExtendedTestSet "Test GMPVoice" begin
    vc = gmpVoice("middle")
    @test isa(vc, GMPVoice)
end


@testset ExtendedTestSet "Test GMPPerson" begin
    pers = gmpPerson("third")
    @test isa(pers, GMPPerson)
end


@testset ExtendedTestSet "Test GMPNumber" begin
    num = gmpNumber("singular")
    @test isa(num, GMPNumber)
end

@testset ExtendedTestSet "Test GMPGender" begin
    gender = gmpGender("feminine")
    @test isa(gender, GMPGender)
end

@testset ExtendedTestSet "Test GMPDegree" begin
    degree = gmpDegree("superlative")
    @test isa(degree, GMPDegree)
end

@testset ExtendedTestSet "Test GMPUninflectedType" begin
    uninfl = gmpUninflectedType("conjunction")
    @test isa(uninfl, GMPUninflectedType)
end


# degree
# uninflected part of speech
