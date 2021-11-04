# Programmer's notes: unit tests

For each analytical type, there is a subdirectory of the `tests` directory with unit tests for the following:

1. read delimited-text data into object model: `test_TYPEdata.jl`
1. write SFST source files for rules and stems: `test_TYPEfst.jl`
1. parse morphological forms to/from FST format: `test_TYPEformatting.jl`
1. parse strings in `Analysis` objects:  `test_TYPEanalysis.jl`
1. test forward-generating forms: `test_TYPEgenerate.jl`


For analytical types that have both regular and irregular forms, unit tests should test each, since their processing pipelines differ.