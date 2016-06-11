### example1
`example1` is an example of a complete project with a library that will be tested.

Build it by calling `build_example1.sh`
This will create a folder named `example1.build`. You can run the test with either `ctest` or `make test` inside this folder.


### example1_processed
`example1_processed` is a copy of `example1_processed`, in which the cpp source code was modified after cmake was executed.

You can see the auto-generated functions `DocTestRegister_[GUID]()` as well as the auto-generated `doctest_registerlibrary.cpp` file.

Build it by calling `build_example1_processed.sh`
