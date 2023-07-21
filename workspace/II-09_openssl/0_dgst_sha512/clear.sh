#!/bin/bash

rm -f test_files/expected_output/TestSimple1Eng.txt
rm -f test_files/expected_output/TestSimple2Rus.txt
rm -f test_files/expected_output/TestSimple1Eng_ASAN.txt
rm -f test_files/expected_output/TestSimple2Rus_ASAN.txt

rm -R tmp_files
mkdir tmp_files
touch tmp_files/.gitkeep
