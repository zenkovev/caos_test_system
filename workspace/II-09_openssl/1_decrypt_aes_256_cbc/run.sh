#!/bin/bash

# Short names for directories

TS=test_files/sources
TI=tmp_files/input
EO=test_files/expected_output
RO=tmp_files/real_output

# Prepare input

mkdir tmp_files/input
mkdir tmp_files/openssl_bash_output

openssl enc -aes-256-cbc -md sha256 -salt -e \
    -in $TS/text_1_inspector.txt -out $TI/text_1_inspector_encrypt.txt \
    -pass pass:secret \
    &> tmp_files/openssl_bash_output/input_text_1_inspector.txt

openssl enc -aes-256-cbc -md sha256 -salt -e \
    -in $TS/text_2_nose.txt -out $TI/text_2_nose_encrypt.txt \
    -pass pass:very_secret \
    &> tmp_files/openssl_bash_output/input_text_2_nose.txt

# Compile program

PROGRAM_NAME=$(cat program_name.txt)

gcc $PROGRAM_NAME -lcrypto -o tmp_files/decrypt \
    &> tmp_files/gcc_compilation.txt
COMPILATION_RESULT=$?

gcc $PROGRAM_NAME -lcrypto -fsanitize=address -o tmp_files/decrypt_ASAN \
    &> tmp_files/gcc_ASAN_compilation.txt
COMPILATION_RESULT_ASAN=$?

# Get real output

mkdir tmp_files/real_output

if (($COMPILATION_RESULT == 0)); then
  cat $TI/text_1_inspector_encrypt.txt | ./tmp_files/decrypt secret \
      &> $RO/TestSimple1Inspector.txt
  cat $TI/text_2_nose_encrypt.txt | ./tmp_files/decrypt very_secret \
      &> $RO/TestSimple2Nose.txt
fi

if (($COMPILATION_RESULT_ASAN == 0)); then
  cat $TI/text_1_inspector_encrypt.txt | ./tmp_files/decrypt_ASAN secret \
      &> $RO/TestSimple1Inspector_ASAN.txt
  cat $TI/text_2_nose_encrypt.txt | ./tmp_files/decrypt_ASAN very_secret \
      &> $RO/TestSimple2Nose_ASAN.txt
fi

# Check real output

chmod +x test_files/check_simple.sh
./test_files/check_simple.sh
chmod -x test_files/check_simple.sh
