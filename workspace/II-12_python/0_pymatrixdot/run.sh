#!/bin/bash

# Short names for directories

PY_HS=test_files/help_scripts
PY_TS=test_files/test_scripts

EO=test_files/expected_output
RO=tmp_files/real_output

# Create expected output for random test

python3 $PY_HS/generate_random_matrix.py > tmp_files/random_matrix.txt
cat tmp_files/random_matrix.txt | python3 $PY_HS/random_expected.py > $EO/TestSimple3Random.txt

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
  cp tmp_files/build/matrix.so tmp_files/matrix.so
  cp $PY_HS/help_matrix_type.py tmp_files/help_matrix_type.py

  python3 $PY_TS/test_basic.py &> $RO/TestSimple1Basic.txt
  python3 $PY_TS/test_size.py &> $RO/TestSimple2Size.txt
  cat tmp_files/random_matrix.txt | python3 $PY_TS/test_random.py &> $RO/TestSimple3Random.txt
fi

chmod +x test_files/check_simple.sh
./test_files/check_simple.sh
chmod -x test_files/check_simple.sh
