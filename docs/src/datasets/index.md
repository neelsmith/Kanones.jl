# Managing Kanones datasets



- You manage rules and stems in delimited-text files
- Kanones has a required directory structure for data files

See the reference section for information on predefined stem types.

## Loading a dataset

Create a `Kanones.Dataset` by passing it the full path to the root directory of your data files.

```@setup kd
repo = pwd() |> dirname |> dirname  |> dirname
datadirectory = repo * "/datasets/synoptic/"
using Kanones
```

```@example kd
kdata = Kanones.Dataset(datadirectory)
```