#!/bin/sh
mkdir example1_processed.build
cd example1_processed.build
cmake ../example1_processed
make
echo
echo "The example was build into example1_processed.build"
echo "The test is inside example1_processed.build/MyLibrary/MyLibrary_DocTest"
echo "Here is its output:"
echo
./MyLibrary/MyLibraryTest
