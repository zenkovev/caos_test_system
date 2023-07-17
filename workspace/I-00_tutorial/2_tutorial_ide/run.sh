#!/bin/bash

PROGRAM_NAME=$(cat program_name.txt)
# get program name, by default $PROGRAM_NAME == tutorial.c
gcc $PROGRAM_NAME -o tmp_files/main &> tmp_files/gcc_compilation.txt
# compile executable file "main" in directory "tmp_files"
# output from stdout and stderr will be in tmp_files/gcc_compilation.txt
COMPILATION_RESULT=$?
# $COMPILATION_RESULT == 0 <=> compilation is successful

mkdir tmp_files/real_output
if (($COMPILATION_RESULT == 0)); then
  ./tmp_files/main &> tmp_files/real_output/TestSimple.txt
fi

chmod +x test_files/check_simple.sh
./test_files/check_simple.sh
chmod -x test_files/check_simple.sh
# give to script test_files/check_simple.sh file access rights on execution
# run script and delete file access rights on execution
