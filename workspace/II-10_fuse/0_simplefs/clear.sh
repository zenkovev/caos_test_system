#!/bin/bash

mountpoint -q tmp_files/mnt
IS_MOUNTED=$?
if (($IS_MOUNTED == 0)); then
  umount ./tmp_files/mnt
fi

rm -R tmp_files
mkdir tmp_files
touch tmp_files/.gitkeep
