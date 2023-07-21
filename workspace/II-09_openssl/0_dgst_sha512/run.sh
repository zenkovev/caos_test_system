#!/bin/bash

# Short names for directories

TI=test_files/input
EO=test_files/expected_output
RO=tmp_files/real_output

# Prepare expected output

mkdir tmp_files/openssl_bash_stderr

cat $TI/gogol_1.txt | openssl dgst -sha512 -hex | awk '{print $2}' | sed 's/^/0x/' \
    1> $EO/TestSimple1Eng.txt \
    2> tmp_files/openssl_bash_stderr/input_gogol_1.txt

cat $TI/gogol_2.txt | openssl dgst -sha512 -hex | awk '{print $2}' | sed 's/^/0x/' \
    1> $EO/TestSimple2Rus.txt \
    2> tmp_files/openssl_bash_stderr/input_gogol_2.txt

cp $EO/TestSimple1Eng.txt $EO/TestSimple1Eng_ASAN.txt
cp $EO/TestSimple2Rus.txt $EO/TestSimple2Rus_ASAN.txt

# Compile program

PROGRAM_NAME=$(cat program_name.txt)

gcc $PROGRAM_NAME -lcrypto -o tmp_files/dgst_sha512 \
    &> tmp_files/gcc_compilation.txt
COMPILATION_RESULT=$?

gcc $PROGRAM_NAME -lcrypto -fsanitize=address -o tmp_files/dgst_sha512_ASAN \
    &> tmp_files/gcc_ASAN_compilation.txt
COMPILATION_RESULT_ASAN=$?

# Get real output

mkdir tmp_files/real_output

if (($COMPILATION_RESULT == 0)); then
  cat $TI/gogol_1.txt | ./tmp_files/dgst_sha512 &> $RO/TestSimple1Eng.txt
  cat $TI/gogol_2.txt | ./tmp_files/dgst_sha512 &> $RO/TestSimple2Rus.txt
fi

if (($COMPILATION_RESULT_ASAN == 0)); then
  cat $TI/gogol_1.txt | ./tmp_files/dgst_sha512_ASAN &> $RO/TestSimple1Eng_ASAN.txt
  cat $TI/gogol_2.txt | ./tmp_files/dgst_sha512_ASAN &> $RO/TestSimple2Rus_ASAN.txt
fi

# Check real output

chmod +x test_files/check_simple.sh
./test_files/check_simple.sh
chmod -x test_files/check_simple.sh
