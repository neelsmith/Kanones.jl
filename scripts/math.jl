using Kanones
repo = pwd()

coreds = Kanones.coredata(repo; atticonly = true)
mathdir = joinpath(repo, "datasets", "math")

mathds = vcat(coreds.dirs, [mathdir]) |> dataset

parser = kParser(mathds)