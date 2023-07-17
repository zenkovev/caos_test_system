#!/bin/bash

FORMAT_LIST_FILE=$1
FORMAT_LIST=$(cat $FORMAT_LIST_FILE)

format_text() {
  INPUT_FILE=$1
  OUTPUT_FILE=$2

  cat $INPUT_FILE \
      | tr -c '[:graph:]' ' ' \
      | sed 's/^ *//' \
      | sed 's/$/ /' \
      | sed 's/[ ]\+/\n/g' \
      > $OUTPUT_FILE

  # tr -c '[:graph:]' ' ': Replace all non-printable characters into spaces
  # sed 's/^ *//': Delete all spaces in begin of line
  # sed 's/$/ /': Add one space in end of line
  # sed 's/[ ]\+/\n/g': Replace all group of spaces into new line
}

mkdir tmp_files/format_output
for file_name in $FORMAT_LIST; do
  if [ -e tmp_files/real_output/$file_name ]; then
    format_text tmp_files/real_output/$file_name tmp_files/format_output/$file_name
  fi
done
