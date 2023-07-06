#!/bin/bash

PROGRAM_NAME=$(cat program_name.txt)
gcc $PROGRAM_NAME -fsanitize=address -o tmp_files/main_ASAN &> tmp_files/gcc_ASAN_compilation.txt
COMPILATION_RESULT=$?

mkdir tmp_files/real_output
if (($COMPILATION_RESULT == 0)); then
  ./tmp_files/main_ASAN &> tmp_files/real_output/TestHard.txt
fi

chmod +x test_files/check_hard.sh
./test_files/check_hard.sh
chmod -x test_files/check_hard.sh
