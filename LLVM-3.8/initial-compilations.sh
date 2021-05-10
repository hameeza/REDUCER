#!/bin/bash

##############################This file contains code to generate un-optimized IR in LLVM-3.8

LLVM_BIN=/home/abc/clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-16.04/bin

##############App_name is application folder name. Like bzip2d, it can be set to any other application name####################

App_name="bzip2d"
$LLVM_BIN/clang -O3 -mllvm -disable-llvm-optzns -c -emit-llvm *.c  
$LLVM_BIN/llvm-link *.bc -o output-o0.bc
$LLVM_BIN/llvm-dis output-o0.bc -o output/$App_name/$App_name-noopt.ll
$LLVM_BIN/opt  -O3  -S output/$App_name/$App_name-noopt.ll -o output/$App_name/selected-IR/$App_name-noopt-o3.ll
