#!/bin/bash

# Short names for directories

PY_HS=test_files/help_scripts
PY_TS=test_files/test_scripts

EO=test_files/expected_output
RO=tmp_files/real_output

# Build python matrix library

PROGRAM_NAME=$(cat program_name.txt)

mkdir tmp_files/build
cd tmp_files/build

cmake -DPROGRAM_NAME=$PROGRAM_NAME ../.. &> ../cmake_and_make_output.txt
make &>> ../cmake_and_make_output.txt
CMAKE_MAKE_RESULT=$?

cd ../..

# Run tests and check real output

mkdir tmp_files/real_output
if (($CMAKE_MAKE_RESULT == 0)); then
  cp tmp_files/build/primes.so tmp_files/primes.so
  cp $PY_HS/help_functions.py tmp_files/help_functions.py

  python3 $PY_TS/test_long_long.py &> $RO/TestHard1LongLong.txt
  python3 $PY_TS/test_negative.py &> $RO/TestHard2Negative.txt
  python3 $PY_TS/test_long_long_neg.py &> $RO/TestHard3LongLongNeg.txt
  python3 $PY_TS/test_special_num.py &> $RO/TestHard4SpecialNum.txt
  python3 $PY_TS/test_special_types.py &> $RO/TestHard5SpecialTypes.txt
fi

chmod +x test_files/check_hard.sh
./test_files/check_hard.sh
chmod -x test_files/check_hard.sh
