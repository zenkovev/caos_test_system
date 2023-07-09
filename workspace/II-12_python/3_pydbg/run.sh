#!/bin/bash

PROGRAM_NAME=$(cat program_name.txt)

mkdir tmp_files/build
cd tmp_files/build

cmake -DPROGRAM_NAME=$PROGRAM_NAME ../.. &> ../cmake_and_make_output.txt
make &>> ../cmake_and_make_output.txt
CMAKE_MAKE_RESULT=$?

cd ../..

TD=test_files/test_debug
RO=tmp_files/real_output

mkdir tmp_files/real_output
if (($CMAKE_MAKE_RESULT == 0)); then
  cp tmp_files/build/pydbg-bin tmp_files/pydbg-bin

  ./tmp_files/pydbg-bin $TD/test_1_commands.txt $TD/test_1_example.py \
      &> $RO/TestSimple1Example.txt
  ./tmp_files/pydbg-bin $TD/test_2_commands.txt $TD/test_2_args.py ahaha abracadbra 12345 \
      &> $RO/TestSimple2Args.txt
  ./tmp_files/pydbg-bin $TD/test_3_commands.txt $TD/test_3_functions.py \
      &> $RO/TestSimple3Functions.txt
  ./tmp_files/pydbg-bin $TD/test_4_commands.txt $TD/test_4_order.py \
      &> $RO/TestSimple4Order.txt
  ./tmp_files/pydbg-bin $TD/test_5_commands.txt $TD/test_5_continue.py \
      &> $RO/TestSimple5Continue.txt
fi

chmod +x test_files/check_simple.sh
./test_files/check_simple.sh
chmod -x test_files/check_simple.sh
