#define DEBUG
#include <iostream>
#include "doctest.h"


TEST_CASE("testing in lib2.cpp") {
    std::cout << "testing in lib2.cpp" << std::endl;
    CHECK((1+1) == 2);
}

// This code was added by doctest_registerlibrary.cmake in order to ensure that the tests are properly run by DocTest.
// Please commit it if needed, it will be added only once, and never modified.
// Before committing, you can remove this comment, as long as you leave the function below.
int DocTestRegister_89f27c0b_f043_4d20_9cdd_d0ad9216a70a() { return 0; }
