#!/bin/bash
LLVM_BIN=/home/hameeza/Downloads/Downloads/clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-16.04/bin
export LD_LIBRARY_PATH=/home/hameeza/Downloads/Downloads/clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-16.04/lib:$LD_LIBRARY_PATH
App_name="bzip2d"

for i in output/$App_name/selected-IR/*
do

fname=`basename $i`

$LLVM_BIN/llc -filetype=obj $i -o output/$App_name/object/$fname.o
$LLVM_BIN/clang++ output/$App_name/object/$fname.o -o output/$App_name/exe-files/$fname
echo $fname
done


