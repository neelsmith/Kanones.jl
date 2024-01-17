@testset "Test look up of LexemeUrns" begin
    dict = Kanones.lsjid_dict(dirname(pwd()))
    agoralex = LexemeUrn("lsj.n761")
    αγορα = dict["αγορα"]
    @test αγορα == agoralex

    fulldict = Kanones.lexid_dict(dirname(pwd()))
    ατρειδης = fulldict["ατρειδης"]
    atreideslex = LexemeUrn("lsjx.n17180")
    @test ατρειδης == atreideslex

end 