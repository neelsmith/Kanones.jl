@testset ExtendedTestSet begin
@testset  "Test construction of uninflected form from a Cite2Urn" begin
    u = Cite2Urn("urn:cite2:kanones:morphforms.v1:1000000001")
    uform = Kanones.gmfUninflected(u)
    @test isa(uform, GMFUninflected)
    @test uform.pos ==  GMPUninflectedType(1)
end

@testset  "Test construction of noun form from a Cite2Urn" begin
    u = Cite2Urn("urn:cite2:kanones:morphforms.v1:2030003500")
    noun = Kanones.gmfNoun(u)
    @test isa(noun, GMFNoun)
    @test noun.ngender == GMPGender(3)
    @test noun.ncase == GMPCase(5)
    @test noun.nnumber == GMPNumber(3)
end

@testset  "Test construction of finite verb form from a Cite2Urn" begin
    u = Cite2Urn("urn:cite2:kanones:morphforms.v1:3313110000")
    vb = Kanones.gmfFiniteVerb(u)
    @test isa(vb, GMFFiniteVerb)
    #@test vb.personlabel == "third"
    #@test vb.numberlabel == "singular"
    #@test vb.tenselabel == "future"
    #@test vb.moodlabel == "indicative"
    #@test vb.voicelabel == "active"
end



@testset "Test composing form objects from `Analysis` objects" begin
    d = tempdir()
    repo = dirname(pwd())
    infl = joinpath(repo, "datasets", "core-infl")
    vocab = joinpath(repo, "datasets", "core-vocab")
    kd = Kanones.Dataset([infl, vocab])
    fst =  joinpath(repo, "fst")
    fullpath = joinpath(d, "testcompile")
    if isdir(fullpath)
        rm(fullpath; recursive = true)
    end
    parser = FstBuilder.buildparser(kd,fst, fullpath)

    parse1 = parsetoken("κελεύσει", parser)[1]
    vb = greekForm(parse1)
    @test vb isa GMFFiniteVerb

    parse2 = parsetoken("γνώμαις", parser)[1]
    noun = greekForm(parse2)
    @test noun isa GMFNoun

    parse3 = parsetoken("καλός", parser)[1]
    adj = greekForm(parse3)
    @test adj isa GMFAdjective

    parse4 = parsetoken("τοῦ", parser)[1]
    pron = greekForm(parse4)
    @test pron isa GMFPronoun

    parse5 = parsetoken("κελεύειν", parser)[1]
    inf = greekForm(parse5)
    @test inf isa GMFInfinitive

    parse6 = parsetoken("κελευόμενον", parser)[1]
    ptcpl = greekForm(parse6)
    @test ptcpl isa GMFParticiple

    parse7 = parsetoken("κελευτέον", parser)[1]
    vadj = greekForm(parse7)
    @test vadj isa GMFVerbalAdjective

    parse8 = parsetoken("γάρ", parser)[1]
    uninfl = greekForm(parse8)
    @test uninfl isa GMFUninflected

    parse9 = parsetoken("καλῶς", parser)
    @test_broken ! isempty(parse9)
    # Not yet implemented

end


@testset "Test constructing `GreekMorphologicalForm`s from different types of source" begin
    conjunctionurn = Cite2Urn("urn:cite2:kanones:morphforms.v1:1000000001")
    @test greekForm(conjunctionUrn) isa GMFUninflected
    @test greekForm("$(COLLECTION_ID).1000000001") isa GMFUninflected
    @test greekForm(FormUrn("$(COLLECTION_ID).1000000001")) isa GMFUninflected

end
end