cmake_minimum_required(VERSION 3.0)

execute_process(COMMAND ${CMAKE_SOURCE_DIR}/clone_doctest_ifneeded.sh WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})

enable_testing()
add_subdirectory(MyLibrary)
