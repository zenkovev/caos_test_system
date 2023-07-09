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

  cat $TI/test_4_long_recursion.csv | ./tmp_files/pycsvcalc-bin &> $RO/TestHard1LongRecursion.csv
  cat $TI/test_5_two_chains.csv | ./tmp_files/pycsvcalc-bin &> $RO/TestHard2TwoChains.csv
  cat $TI/test_6_types.csv | ./tmp_files/pycsvcalc-bin &> $RO/TestHard3Types.csv
  cat $TI/test_7_letter_case.csv | ./tmp_files/pycsvcalc-bin &> $RO/TestHard4LetterCase.csv
  cat $TI/test_8_operation_order.csv | ./tmp_files/pycsvcalc-bin &> $RO/TestHard5OperationOrder.csv
  cat $TI/test_9_void_cell_link.csv | ./tmp_files/pycsvcalc-bin &> $RO/TestHard6VoidCellLink.csv
  cat $TI/test_10_not_links_in_str.csv | ./tmp_files/pycsvcalc-bin &> $RO/TestHard7NotLinksInStr.csv
fi

chmod +x test_files/check_hard.sh
./test_files/check_hard.sh
chmod -x test_files/check_hard.sh
