
@testset "Test IO for delimited text" begin
    delimited = "irreginf.irregptcpln31130a|lsj.n31130|ὤν|present|active|masculine|nominative|singular|irregularparticiple"
    irrptcplio = Kanones.IrregularParticipleIO("IO for irregular participles")
    stem = Kanones.readstemrow(irrptcplio, delimited)
    @test stem isa Kanones.IrregularParticipleStem

    expected = "irreginf.irregptcpln31130a|Irregular participle form ὤν (present active masculine nominative singular|ὤν|lsj.n31130|irregularparticiple|present|active|masculine|nominative|singular"

    @test Unicode.normalize(cex(stem)) == Unicode.normalize(expected)


end