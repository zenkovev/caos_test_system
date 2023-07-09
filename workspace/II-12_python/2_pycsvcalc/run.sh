#!/bin/bash

PROGRAM_NAME=$(cat program_name.txt)

mkdir tmp_files/build
cd tmp_files/build

cmake -DPROGRAM_NAME=$PROGRAM_NAME ../.. &> ../cmake_and_make_output.txt
make &>> ../cmake_and_make_output.txt
CMAKE_MAKE_RESULT=$?

cd ../..

TI=test_files/input
RO=tmp_files/real_output

mkdir tmp_files/real_output
if (($CMAKE_MAKE_RESULT == 0)); then
  cp tmp_files/build/pycsvcalc-bin tmp_files/pycsvcalc-bin

  cat $TI/test_1_int.csv | ./tmp_files/pycsvcalc-bin &> $RO/TestSimple1Int.csv
  cat $TI/test_2_float.csv | ./tmp_files/pycsvcalc-bin &> $RO/TestSimple2Float.csv
  cat $TI/test_3_str.csv | ./tmp_files/pycsvcalc-bin &> $RO/TestSimple3Str.csv
fi

chmod +x test_files/check_simple.sh
./test_files/check_simple.sh
chmod -x test_files/check_simple.sh
