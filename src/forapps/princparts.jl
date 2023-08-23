

"""Compose an array of strings for 6 principal part for a given verb.
$(SIGNATURES)
"""
function principalparts(lexu::LexemeUrn, ds::Kanones.FilesDataset)
    [
        pp1(lexu, ds),
        pp2(lexu, ds),
        pp3(lexu, ds),
        pp4(lexu, ds),
        pp5(lexu, ds),
        pp6(lexu, ds)
    ]
end


"""Generate first principal part for a given verb in a dataset.
$(SIGNATURES)
"""
function pp1(lexu::LexemeUrn, ds::Kanones.FilesDataset; conjunction = "; ")
    activeurn = GMFFiniteVerb(
        gmpPerson("first"),
        gmpNumber("singular"),
        gmpTense("present"),
        gmpMood("indicative"),
        gmpVoice("active")
    ) |> formurn
    activeforms = generate(lexu, activeurn, ds)
    if ! isempty(activeforms)
        join(activeforms[1],conjunction)
    else

        passiveurn = GMFFiniteVerb(
        gmpPerson("first"),
        gmpNumber("singular"),
        gmpTense("present"),
        gmpMood("indicative"),
        gmpVoice("passive")
    ) |> formurn
        passiveforms = generate(lexu, passiveurn, ds)
        isempty(passiveforms) ? "-" : join(passiveforms, conjunction)
    end
end


"""Generate second principal part for a given verb in a dataset.
$(SIGNATURES)
"""
function pp2(lexu::LexemeUrn, ds::Kanones.FilesDataset; conjunction = "; ")
    activeurn = GMFFiniteVerb(
        gmpPerson("first"),
        gmpNumber("singular"),
        gmpTense("future"),
        gmpMood("indicative"),
        gmpVoice("active")
    ) |> formurn
    activeforms = generate(lexu, activeurn, ds)
    if ! isempty(activeforms)
        join(activeforms, conjunction)
    else

        middleurn = GMFFiniteVerb(
        gmpPerson("first"),
        gmpNumber("singular"),
        gmpTense("future"),
        gmpMood("indicative"),
        gmpVoice("middle")
    ) |> formurn
        middleforms = generate(lexu, middleurn, ds)
        isempty(middleforms) ? "-" : join(middleforms, conjunction)
    end
end


"""Generate third principal part for a given verb in a dataset.
$(SIGNATURES)
"""
function pp3(lexu::LexemeUrn, ds::Kanones.FilesDataset; conjunction = "; ")
    activeurn = GMFFiniteVerb(
        gmpPerson("first"),
        gmpNumber("singular"),
        gmpTense("aorist"),
        gmpMood("indicative"),
        gmpVoice("active")
    ) |> formurn
    activeforms = generate(lexu, activeurn, ds)
    if ! isempty(activeforms)
        join(activeforms, conjunction)
    else

        middleurn = GMFFiniteVerb(
        gmpPerson("first"),
        gmpNumber("singular"),
        gmpTense("aorist"),
        gmpMood("indicative"),
        gmpVoice("middle")
    ) |> formurn
        middleforms = generate(lexu, middleurn, ds)
        isempty(middleforms) ? "-" : join(middleforms, conjunction)
    end
end




"""Generate fourth principal part for a given verb in a dataset.
$(SIGNATURES)
"""
function pp4(lexu::LexemeUrn, ds::Kanones.FilesDataset;conjunction = "; ")
    activeurn = GMFFiniteVerb(
        gmpPerson("first"),
        gmpNumber("singular"),
        gmpTense("perfect"),
        gmpMood("indicative"),
        gmpVoice("active")
    ) |> formurn
    activeforms = generate(lexu, activeurn, ds)
    isempty(activeforms) ? "-" : join(activeforms,conjunction)
end


"""Generate fourth principal part for a given verb in a dataset.
$(SIGNATURES)
"""
function pp5(lexu::LexemeUrn, ds::Kanones.FilesDataset; conjunction = "; ")
    passiveurn = GMFFiniteVerb(
        gmpPerson("first"),
        gmpNumber("singular"),
        gmpTense("perfect"),
        gmpMood("indicative"),
        gmpVoice("passive")
    ) |> formurn
    passiveforms = generate(lexu, passiveurn, ds)
    isempty(passiveforms) ? "-" : join(passiveforms,conjunction)
end



"""Generate sixth principal part for a given verb in a dataset.
$(SIGNATURES)
"""
function pp6(lexu::LexemeUrn, ds::Kanones.FilesDataset; conjunction = "; ")
    passiveurn = GMFFiniteVerb(
        gmpPerson("first"),
        gmpNumber("singular"),
        gmpTense("aorist"),
        gmpMood("indicative"),
        gmpVoice("passive")
    ) |> formurn
    passiveforms = generate(lexu, passiveurn, ds)
    isempty(passiveforms) ? "-" : join(passiveforms,conjunction)
end