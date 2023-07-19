#!/bin/bash

# Make executable file

PROGRAM_NAME=$(cat program_name.txt)

mkdir tmp_files/build
cd tmp_files/build

cmake -DPROGRAM_NAME=$PROGRAM_NAME ../.. &> ../cmake_and_make_output.txt
make &>> ../cmake_and_make_output.txt
CMAKE_MAKE_RESULT=$?

cd ../..

# Get real output

mkdir tmp_files/real_output
if (($CMAKE_MAKE_RESULT == 0)); then
  cp tmp_files/build/unzipfs tmp_files/unzipfs

  mkdir tmp_files/mnt
  ./tmp_files/unzipfs ./tmp_files/mnt --src test_files/files.zip \
      2> tmp_files/real_output/TestSimple1Mnt.txt

  ls -R tmp_files/mnt \
      &> tmp_files/real_output/TestSimple2Dirs.txt
  find tmp_files/mnt -type f | sort | xargs cat \
      &> tmp_files/real_output/TestSimple3Files.txt
fi

# Check real output

chmod +x test_files/check_simple.sh
./test_files/check_simple.sh
chmod -x test_files/check_simple.sh
