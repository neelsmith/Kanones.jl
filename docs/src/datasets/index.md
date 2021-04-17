# Managing Kanones datasets



- You manage rules and stems in delimited-text files
- Kanones has a required directory structure for data files

See the reference section for information on predefined stem types.


## Loading a dataset

Use the `dataset` function to create a `Kanones.Dataset`.


Pass in a list of full paths to one or more directories laid out according to Kanones conventions, and optionally an orthography.  The default orthogrpahy is `LiteraryGreekOthography`.

```@setup kd
repo = pwd() |> dirname |> dirname  |> dirname
src1 = repo * "/datasets/synoptic/"
src2 = repo * "/datasets/core/"
using Kanones
```

```@example kd
datasrcs = [src1, src2]
kdata = dataset(datasrcs)
```





## Working with stems and rules


- rulesarray
- stemsarray