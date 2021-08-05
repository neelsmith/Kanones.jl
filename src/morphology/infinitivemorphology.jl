
"""Compose URN for infinitive verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function infinitivefromfst(fstdata)
    # Example rule string:
    #  "<w_regular><infinitive>εσθαι<present><middle><u>infinfl.wreg2</u>"
    # Extract TV from a string like the example:
    verbrulere = r"<[^<]+><infinitive>[^<]*<([^<]+)><([^<]+)>"
    matchedup = collect(eachmatch(verbrulere, fstdata))

    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\" as verb form.")
        nothing
    else
        (t, v) = matchedup[1].captures
        tensedict = labeldict(tensepairs)
        voicedict = labeldict(voicepairs)
        verbform = InfinitiveForm(
        tensedict[t], t,
        voicedict[v], v
        )
    end
end
