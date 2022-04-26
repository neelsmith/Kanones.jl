@testset "Test constructors, labelling and codes for person property" begin
    pers =  gmpPerson(1)
    @test pers == gmpPerson("first")
    @test code(pers) == 1
    @test label(pers) == "first"
end

@testset "Test constructors, labelling and codes for number property" begin
    num =  gmpNumber(1)
    @test num == gmpNumber("singular")
    @test code(num) == 1
    @test label(num) == "singular"
end

@testset "Test constructors, labelling and codes for tense property" begin
    tns =  gmpTense(1)
    @test tns == gmpTense("present")
    @test code(tns) == 1
    @test label(tns) == "present"
end


@testset "Test constructors, labelling and codes for mood property" begin
    mood =  gmpMood(1)
    @test mood == gmpMood("indicative")
    @test code(mood) == 1
    @test label(mood) == "indicative"
end


@testset "Test constructors, labelling and codes for voice property" begin
    voice =  gmpVoice(1)
    @test voice == gmpVoice("active")
    @test code(voice) == 1
    @test label(voice) == "active"
end


@testset "Test constructors, labelling and codes for gender property" begin
    gender =  gmpGender(1)
    @test gender == gmpGender("masculine")
    @test code(gender) == 1
    @test label(gender) == "masculine"
end



@testset "Test constructors, labelling and codes for case property" begin
    grammcase =  gmpCase(1)
    @test grammcase == gmpCase("nominative")
    @test code(grammcase) == 1
    @test label(grammcase) == "nominative"
end

@testset "Test constructors, labelling and codes for uninflected type property" begin
    
    uninfl = gmpUninflectedType("preposition")
    @test uninfl == gmpUninflectedType(2)
    @test code(uninfl) == 2
    @test label(uninfl) == "preposition"
end
