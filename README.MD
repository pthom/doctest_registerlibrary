

Note:
A more recent version of this project provides test registration without requiring code modifications, through the use of cmake `add_library(...OBJECT ...)`. 

It works with catch, googletest and doctest, and is located at 
https://github.com/pthom/cmake_registertest

# Static library "doctesting" made easy with cmake

#### Motivation
The [doctest](https://github.com/onqtam/doctest) documentation says rightfully:
> Tests can be considered a form of documentation and should be able to reside near the production code which they test.*

In the case of a static library, this means that the tests code should reside directly inside the library source files, and *not* inside separate source files.

Unfortunately, the self-registration of the tests does not work as desired when you link a static library : your tests might not be launched at all! This is due to the fact that the linker often strips the self-registration code when it is inside a library.
For a more thorough explanation, see : https://github.com/onqtam/doctest/issues/21


This project provides a solution, based on the further assumption that :
> Adding tests to a library should be straightforward. Ideally, it should be possible to do it by using a one-line instruction in the library's CMakeList file.


## Quick usage instructions

`doctest_registerlibrary.cmake` provides several cmake functions that make it possible to add tests to a library, using a one-liner instruction in your `CMakeList.txt` file.

For example :
```
add_library(MyLibrary STATIC lib1.cpp lib2.cpp)
# The line below will activate the tests for the library !
doctest_register_static_library(MyLibrary MyLibraryTest)  
```

This one-liner will :
- ensure that all tests are actually run. It will add minimal modifications to your code in order to ensure this. More details about this in the [examples](examples/)
- append the doctest include path to your library
- create an executable test target (MyLibraryTest) for your library
- register it as a cmake test (so that `ctest` or `make test`) will launch it.



## Detailed usage instructions :

#### Step 1 : include doctest and doctest_registerlibrary in your project

For example, clone [doctest](https://github.com/onqtam/doctest) and [doctest_registerlibrary](https://github.com/pthom/doctest_registerlibrary) at the root of your project, such as shown below:
```
YourProject/
├── CMakeLists.txt
├── YourLibrary/
│   ├── CMakeLists.txt
│   ├── lib1.cpp
│   └── lib2.cpp
├── doctest
│   ├── doctest/
│   ├── ...
│   └── scripts
└── doctest_registerlibrary/
    ├── doctest_main.cpp
    ├── doctest_registerlibrary.cmake
    └── doctest_registerlibrary.py
```

#### Step 2 : Adjust the paths in `doctest_registerlibrary.cmake`

If needed, adjust the paths in the first two lines of `doctest_registerlibrary.cmake`

```
set (doctest_lib_location ${CMAKE_SOURCE_DIR}/doctest)
set (doctest_registerlibrary_location ${CMAKE_SOURCE_DIR}/doctest_registerlibrary)
```


#### Step 3 : enable tests for your project
Enable tests in cmake, by adding the following line to your project's main `CMakeLists.txt` file:

```
enable_testing()
```

#### Step 4 : Register tests for your library

in the `CMakeLists.txt` of your library
* Include "doctest_registerlibrary.cmake"
* Call `doctest_register_static_library(YourLibrary YourLibraryTest)` (where YourLibrary is the name of your library and YourLibraryTest is the name of the test executable that will be created)

Example :
```
include("${CMAKE_SOURCE_DIR}/doctest_registerlibrary/doctest_registerlibrary.cmake")
add_library(MyLibrary STATIC lib1.cpp lib2.cpp)
doctest_register_static_library(YourLibrary YourLibraryTest)
```

##  'A la carte' instructions

`doctest_register_static_library(YourLibrary YourLibraryTest)` does different actions that can be called separately. See below  for the detail of those actions.

### auto-generated code

##### doctest_registercppfiles
`doctest_registercppfiles(YourLibrary)` will make some small changes to your cpp files in order to ensure that tests are actually run : it will modify your cpp files by adding a dummy function `DocTestRegister_[GUID]()`.
  This modification is done only once, and can be committed. Your cpp files will not be modified unless they actually use doctest (i.e they include `doctest.h` or they include a `TEST_CASE`)


##### doctest_create_registermainfile
`doctest_create_registermainfile(YourLibrary)` will create a file `doctest_registerlibrary.cpp` that will call these dummy functions : this is the secret in order to make the self-registration of tests work with a static library.
This file can also be committed and will only be modified when new source files are added to the library.

##### More details

See [the examples](examples/) for more details.

### Utilities

##### doctest_appendregisterlibrarycpp_tosources
`doctest_appendregisterlibrarycpp_tosources(YourLibrary)` can be used in conjunction with `doctest_registercppfiles()`. It will add the `doctest_registerlibrary.cpp` file to your library sources files.

##### doctest_addincludepath
`doctest_addincludepath(YourLibrary)` will simply add the doctest include path to your library.

##### doctest_maketesttarget
`doctest_maketesttarget(YourLibrary YourLibraryTest)` will create an executable target for your tests

##### doctest_register_ctest
`doctest_register_ctest(YourLibraryTest)` will register this exe as a test (so that `make test` or `ctest` will launch it)
