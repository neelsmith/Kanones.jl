



# Kanones.jl

A julia package implementing the kanónes system for building Greek morphological parsers.



## Unit tests

Kanones includes an extensive suite of unit tests that take some time to run.  To run all of all them, just use the standard `test` command from package mode (and be prepared to wait).

If you want to run a selection of tests, you can do that from the `tests` directory by running `julia select_tests.jl [FILENAMES]`.  `select_tests.jl` uses the `TestSetExtensions.jl` package; if you prefer its reporting format, you can run all the tests with  `julia select_tests.jl test* */test*jl`.
