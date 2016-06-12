include("${CMAKE_SOURCE_DIR}/doctest_registerlibrary/doctest_registerlibrary.cmake")


set(sources lib1.cpp lib2.cpp)
add_library(MyLibrary STATIC ${sources})
set_property(TARGET MyLibrary PROPERTY CXX_STANDARD 11)
doctest_registerlibrary(MyLibrary MyLibraryTest)
