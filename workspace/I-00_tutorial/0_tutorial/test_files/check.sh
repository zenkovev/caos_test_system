#!/bin/bash

CHECK_LIST_FILE=$1
CHECK_LIST=$(cat $CHECK_LIST_FILE)

special_color_symbol=$(printf '\033')
red_color_format_string="s,.*,${special_color_symbol}[1;31m&${special_color_symbol}[0m,"
green_color_format_string="s,.*,${special_color_symbol}[1;32m&${special_color_symbol}[0m,"

for file_name in $CHECK_LIST; do
  diff test_files/expected_output/$file_name tmp_files/real_output/$file_name &> /dev/null
  DIFFER=$?
  if (($DIFFER == 0))
  then
      echo "File $file_name is correct" | sed $green_color_format_string
  else
      echo "File $file_name is not correct" | sed $red_color_format_string
  fi
done
