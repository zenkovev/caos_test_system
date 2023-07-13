#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TASK_DIR=$SCRIPT_DIR/..

cd $SCRIPT_DIR

mkdir $TASK_DIR/tmp_files/class_sources
CPP=$TASK_DIR/test_files/class_cpp
SRC=$TASK_DIR/tmp_files/class_sources

g++ -shared -fPIC $CPP/SimpleClass.cpp -o $SRC/SimpleClass.so
g++ -shared -fPIC $CPP/SpecialClass.cpp -o $SRC/SpecialClass.so

mkdir $SRC/some
mkdir $SRC/some/package

g++ -shared -fPIC $CPP/some/package/ClassInPackage.cpp -o $SRC/some/package/ClassInPackage.so

mkdir $SRC/std
mkdir $SRC/std/exe
mkdir $SRC/exe
mkdir $SRC/exe/std
mkdir $SRC/abra
mkdir $SRC/abra/std
mkdir $SRC/abra/std/cadabra

g++ -shared -fPIC $CPP/std/Example1.cpp -o $SRC/std/Example1.so
g++ -shared -fPIC $CPP/std/exe/Example2.cpp -o $SRC/std/exe/Example2.so
g++ -shared -fPIC $CPP/exe/std/Example3.cpp -o $SRC/exe/std/Example3.so
g++ -shared -fPIC $CPP/abra/std/cadabra/Example4.cpp -o $SRC/abra/std/cadabra/Example4.so

cd $TASK_DIR
