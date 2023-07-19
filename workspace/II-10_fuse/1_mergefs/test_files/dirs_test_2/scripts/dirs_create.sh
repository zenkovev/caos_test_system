#!/bin/bash

mkdir tmp_files/dirs_for_union
cd tmp_files/dirs_for_union

mkdir A
mkdir B
mkdir A/A
mkdir B/A

sleep 0.01
echo -n "ЛОСЬ" > A/A/1.txt
sleep 0.01
echo -n "ЛУПА" > B/A/1.txt
sleep 0.01
echo -n "ЛИСТ" > B/1.txt
sleep 0.01
echo -n "ЛИПА" > A/1.txt
sleep 0.01
echo -n "ЛОСКУТ" > B/A/2.txt
sleep 0.01
echo -n "ЛАМПА" > B/2.txt
sleep 0.01
echo -n "ЛЯГУШКА" > A/2.txt
sleep 0.01
echo -n "ЛАЧУГА" > A/A/2.txt

cd ../..
