#!/bin/sh
mkdir example1.build
cd example1.build
cmake ../example1
make
echo
echo "The example was build into example1.build"
echo "The test is inside example1.build/MyLibrary/MyLibrary_DocTest"
echo "Here is its output:"
echo
./MyLibrary/MyLibraryTest
