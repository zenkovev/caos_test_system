#!/bin/bash

# Compile executable files

PROGRAM_NAME=$(cat program_name.txt)

gcc $PROGRAM_NAME -ldl -o tmp_files/simple_dlopen \
    &> tmp_files/gcc_compilation.txt
COMPILATION_RESULT=$?

gcc $PROGRAM_NAME -ldl -fsanitize=address -o tmp_files/simple_dlopen_ASAN \
    &> tmp_files/gcc_ASAN_compilation.txt
COMPILATION_ASAN_RESULT=$?

# Build libraries

mkdir tmp_files/lib_binary
gcc -shared -fPIC test_files/lib_sources/special.c -o tmp_files/lib_binary/libspecial.so
gcc -shared -fPIC test_files/lib_sources/other.c -o tmp_files/lib_binary/libother.so

# Get real output

mkdir tmp_files/real_output

make_real_output() {
  INPUT_FILE=$1
  BINARY_FILE=$2

  OUTPUT_SUFF_NUM=$3
  OUTPUT_SUFF_BIN=$4

  OUTPUT_MUL_FILE="TestSimple1Mul_${OUTPUT_SUFF_NUM}${OUTPUT_SUFF_BIN}.txt"
  OUTPUT_DIV_FILE="TestSimple2Div_${OUTPUT_SUFF_NUM}${OUTPUT_SUFF_BIN}.txt"
  OUTPUT_INT_FILE="TestSimple3Int_${OUTPUT_SUFF_NUM}${OUTPUT_SUFF_BIN}.txt"

  cat test_files/input/$INPUT_FILE \
      | ./tmp_files/$BINARY_FILE ./tmp_files/lib_binary/libspecial.so mul_two \
      &> tmp_files/real_output/$OUTPUT_MUL_FILE

  cat test_files/input/$INPUT_FILE \
      | ./tmp_files/$BINARY_FILE ./tmp_files/lib_binary/libspecial.so div_two \
      &> tmp_files/real_output/$OUTPUT_DIV_FILE

  cat test_files/input/$INPUT_FILE \
      | ./tmp_files/$BINARY_FILE ./tmp_files/lib_binary/libother.so to_int_and_back \
      &> tmp_files/real_output/$OUTPUT_INT_FILE
}

if (($COMPILATION_RESULT == 0)); then
  make_real_output numbers_1.txt simple_dlopen "Num1" ""
  make_real_output numbers_2.txt simple_dlopen "Num2" ""
fi

if (($COMPILATION_ASAN_RESULT == 0)); then
  make_real_output numbers_1.txt simple_dlopen_ASAN "Num1" "_ASAN"
  make_real_output numbers_2.txt simple_dlopen_ASAN "Num2" "_ASAN"
fi

# Check real output

chmod +x test_files/check_simple.sh
./test_files/check_simple.sh
chmod -x test_files/check_simple.sh
