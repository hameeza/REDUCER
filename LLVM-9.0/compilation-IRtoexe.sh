#!/bin/bash

################This converts IR codes to executables################
LLVM_BIN=/home/abc/clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-18.04/bin
export LD_LIBRARY_PATH=/home/abc/clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-18.04/lib:$LD_LIBRARY_PATH
App_name="bzip2d"

for i in output/$App_name/selected-IR/*
do
fname=`basename $i`
$LLVM_BIN/llc -filetype=obj $i -o output/$App_name/object/$fname.o
$LLVM_BIN/clang++ output/$App_name/object/$fname.o -o output/$App_name/exe-files/$fname
echo $fname
done
