#!/bin/bash

chmod +x test_files/format.sh
./test_files/format.sh test_files/check_hard_list.txt
chmod -x test_files/format.sh

chmod +x test_files/check.sh
./test_files/check.sh test_files/check_hard_list.txt
chmod -x test_files/check.sh
