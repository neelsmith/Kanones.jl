@testset "Test validating a dataset" begin
    # Set up a tiny, stable, test data set 
    ds = joinpath(pwd(), "assets", "literarygreek-rules") |> dataset
    @test ds isa Kanones.FilesDataset

    classmap = Kanones.lexemeclassindex(ds)
    @test classmap[1] isa NamedTuple{(:lexemeid, :inflclass), Tuple{String, String}}

    # all references in stems to inflectional types appear in rules

    #=
 all URNs in stems, rules and lexeme tables use registered URNs
 all references in stems to lexemes appear in lexeme collection
 ensure that all URNs for rules, stems and lexemes are unique
 ensure that all references in compound stems to simplex stems exist
    =#

end