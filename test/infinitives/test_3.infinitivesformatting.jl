@testset "Test parsing an InfinitiveForm from SFST output" begin
    sfst = "<u>verbstems.n56496</u><u>lsj.n56496</u><stem>κελευ<finiteverb><w_regular><div><w_regular><infinitive>ειν<present><active><u>infinfl.wreg1</u>"
    infl = split(sfst,"<div>")[2]
    infinitive = Kanones.infinitivefromfst(infl)
    expected = InfinitiveForm(1, 1)
    @test infinitive == expected
end
@testset "Test parsing a NounForm from a FormUrn" begin
    frm = FormUrn("morphforms.400101000")
    @test Kanones.infinitiveform(frm) == InfinitiveForm(1,1)
end

