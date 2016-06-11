#include <iostream>
#define DEBUG // Quick hack against DOCTEST_BREAK_INTO_DEBUGGER not being defined
#include "doctest.h"


int factorial(int number) { return number <= 1 ? number : factorial(number - 1) * number; }

TEST_CASE("testing the factorial function") {
  std::cout << "testing in lib1.cpp" << std::endl;
  CHECK(factorial(1) == 1);
  CHECK(factorial(2) == 2);
  CHECK(factorial(10) == 3628800);
}

// This code was added by doctest_registerlibrary.cmake in order to ensure that the tests are properly run by DocTest.
// Please commit it if needed, it will be added only once, and never modified.
// Before committing, you can remove this comment, as long as you leave the function below.
int DocTestRegister_f3521254_e571_4345_b818_16c2a8f67761() { return 0; }
