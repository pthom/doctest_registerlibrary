### example1
`example1/` is an example of a complete project with a library that will be tested.

Build it by calling `build_example1.sh`
This will create a folder named `example1.build`. You can run the test with either `ctest` or `make test` inside this folder.


### example1_processed
`example1_processed/` is a copy of `example1/`, in which the cpp source code was modified after cmake was executed.

You can see the auto-generated functions `DocTestRegister_[GUID]()` as well as the auto-generated `doctest_registerlibrary.cpp` file.

Build it by calling `build_example1_processed.sh`


### detailed differences

```
▶ diff -Naur example1/MyLibrary example1_processed/MyLibrary

##########################################################
# auto-generated code in lib1.cpp :
##########################################################

diff -Naur example1/MyLibrary/lib1.cpp example1_processed/MyLibrary/lib1.cpp
--- example1/MyLibrary/lib1.cpp
+++ example1_processed/MyLibrary/lib1.cpp
+
+// This code was added by doctest_registerlibrary.cmake in order to ensure that the tests are properly run by DocTest.
+// Please commit it if needed, it will be added only once, and never modified.
+// Before committing, you can remove this comment, as long as you leave the function below.
+int DocTestRegister_f3521254_e571_4345_b818_16c2a8f67761() { return 0; }

##########################################################
# auto-generated code in lib2.cpp :
##########################################################

diff -Naur example1/MyLibrary/lib2.cpp example1_processed/MyLibrary/lib2.cpp
--- example1/MyLibrary/lib2.cpp
+++ example1_processed/MyLibrary/lib2.cpp
+
+// This code was added by doctest_registerlibrary.cmake in order to ensure that the tests are properly run by DocTest.
+// Please commit it if needed, it will be added only once, and never modified.
+// Before committing, you can remove this comment, as long as you leave the function below.
+int DocTestRegister_89f27c0b_f043_4d20_9cdd_d0ad9216a70a() { return 0; }


##########################################################
# auto-generated file doctest_registerlibrary.cpp :
##########################################################

diff -Naur example1/MyLibrary/doctest_registerlibrary.cpp example1_processed/MyLibrary/doctest_registerlibrary.cpp
--- example1/MyLibrary/doctest_registerlibrary.cpp
+++ example1_processed/MyLibrary/doctest_registerlibrary.cpp
+
+// This file is autogenerated.
+// It was added by doctest_registerlibrary.cmake in order to ensure that the tests are properly run by DocTest.
+// Please commit it if needed, it will be modified only if new files are added.
+
+int DocTestRegister_f3521254_e571_4345_b818_16c2a8f67761();
+int DocTestRegister_89f27c0b_f043_4d20_9cdd_d0ad9216a70a();
+
+
+int DocTestRegister()
+{
+  int dummy_sum = 0;
+  dummy_sum += DocTestRegister_f3521254_e571_4345_b818_16c2a8f67761();
+  dummy_sum += DocTestRegister_89f27c0b_f043_4d20_9cdd_d0ad9216a70a();
+
+  return dummy_sum;
+}
```
