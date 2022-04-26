@testset ExtendedTestSet "Test citable trait for PronounStem" begin
    cexsrc = "pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article"
    pronounio = Kanones.PronounIO("pronouns")
    stem = Kanones.readstemrow(pronounio, cexsrc)

    @test label(stem) == "Stem ὁ (article: masculine, nominative, singular)"
    @test urn(stem) == StemUrn("pronoun.n71882a")
    @test cex(stem) == "pronoun.n71882a|Stem ὁ (article: masculine, nominative, singular)"

    dict = Dict(
       "pronoun" => "urn:cite2:kanones:pronoun.v1:"
       )
    @test urn(stem; registry = dict) == Cite2Urn("urn:cite2:kanones:pronoun.v1:n71882a")
    @test cex(stem; registry = dict) == "urn:cite2:kanones:pronoun.v1:n71882a|Stem ὁ (article: masculine, nominative, singular)"
end
