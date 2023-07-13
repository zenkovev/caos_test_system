#!/bin/bash

# Compile executable files

PROGRAM_NAME=$(cat program_name.txt)

mkdir tmp_files/gcc_compilation
mkdir tmp_files/bin

SRC=test_files/sources
BIN=tmp_files/bin
OUT=tmp_files/gcc_compilation

g++ $PROGRAM_NAME $SRC/main_basic.cpp -ldl -o $BIN/main_basic \
    &> $OUT/main_basic.txt
COMPILATION_RESULT_BASIC=$?

g++ $PROGRAM_NAME $SRC/main_std.cpp -ldl -o $BIN/main_std \
    &> $OUT/main_std.txt
COMPILATION_RESULT_STD=$?

g++ $PROGRAM_NAME $SRC/main_basic.cpp -ldl -fsanitize=address -o $BIN/main_basic_ASAN \
    &> $OUT/main_basic_ASAN.txt
COMPILATION_RESULT_BASIC_ASAN=$?

g++ $PROGRAM_NAME $SRC/main_std.cpp -ldl -fsanitize=address -o $BIN/main_std_ASAN \
    &> $OUT/main_std_ASAN.txt
COMPILATION_RESULT_STD_ASAN=$?

# Make all libraries

chmod +x test_files/make_all_libs.sh
./test_files/make_all_libs.sh
chmod -x test_files/make_all_libs.sh

# Get real output

mkdir tmp_files/real_output

BIN=tmp_files/bin
RO=tmp_files/real_output

if (($COMPILATION_RESULT_BASIC == 0)); then
  export CLASSPATH=tmp_files/class_sources
  ./$BIN/main_basic &> $RO/TestSimple1Basic.txt
fi

if (($COMPILATION_RESULT_STD == 0)); then
  export CLASSPATH=tmp_files/class_sources
  ./$BIN/main_std &> $RO/TestSimple2Std.txt
fi

if (($COMPILATION_RESULT_BASIC_ASAN == 0)); then
  export CLASSPATH=tmp_files/class_sources
  export ASAN_OPTIONS=alloc_dealloc_mismatch=0
  ./$BIN/main_basic_ASAN &> $RO/TestSimple1Basic_ASAN.txt
fi

if (($COMPILATION_RESULT_STD_ASAN == 0)); then
  export CLASSPATH=tmp_files/class_sources
  export ASAN_OPTIONS=alloc_dealloc_mismatch=0
  ./$BIN/main_std_ASAN &> $RO/TestSimple2Std_ASAN.txt
fi

# Check real output

chmod +x test_files/check_simple.sh
./test_files/check_simple.sh
chmod -x test_files/check_simple.sh
