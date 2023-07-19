#!/bin/bash

# Prepare catalogs for making merge file system

chmod +x test_files/dirs_test_2/scripts/dirs_create.sh
./test_files/dirs_test_2/scripts/dirs_create.sh
chmod -x test_files/dirs_test_2/scripts/dirs_create.sh

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
  cp tmp_files/build/mergefs tmp_files/mergefs

  mkdir tmp_files/mnt
  DU=tmp_files/dirs_for_union
  ./tmp_files/mergefs ./tmp_files/mnt --src $DU/A:$DU/B:$DU/A/A:$DU/B/A \
      2> tmp_files/real_output/TestHard1Mnt.txt

  ls -R tmp_files/mnt \
      &> tmp_files/real_output/TestHard2Dirs.txt
  find tmp_files/mnt -type f | sort | xargs cat \
      &> tmp_files/real_output/TestHard3Files.txt
fi

# Check real output

chmod +x test_files/check_hard.sh
./test_files/check_hard.sh
chmod -x test_files/check_hard.sh
