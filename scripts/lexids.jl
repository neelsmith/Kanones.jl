# Check for duplicate entries in lexids lists
using Kanones

lsjdict = Kanones.lsjid_dict()
fulldict = Kanones.lexid_dict()


lsjkeys = keys(lsjdict) |> collect
allkeys = keys(fulldict) |> collect
