#!/bin/bash

# Short names for directories

PY_HS=test_files/help_scripts
PY_TS=test_files/test_scripts

EO=test_files/expected_output
RO=tmp_files/real_output

# Create expected output for random test

python3 $PY_HS/generate_random_numbers.py > tmp_files/random_numbers.txt
cat tmp_files/random_numbers.txt | python3 $PY_HS/random_expected.py > $EO/TestSimple2Random.txt

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

  python3 $PY_TS/test_basic.py &> $RO/TestSimple1Basic.txt
  cat tmp_files/random_numbers.txt | python3 $PY_TS/test_random.py &> $RO/TestSimple2Random.txt
fi

chmod +x test_files/check_simple.sh
./test_files/check_simple.sh
chmod -x test_files/check_simple.sh
