#!/bin/bash


LLVM_BIN=/home/hameeza/Downloads/Downloads/clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-16.04/bin

App_name="bzip2d"


$LLVM_BIN/clang -O3 -mllvm -disable-llvm-optzns -c -emit-llvm *.c  

#$LLVM_BIN/clang -O0 -c -emit-llvm  *.c 
#$LLVM_BIN/clang -O0 -c -emit-llvm  bitcnt_1.c -o bitcnt_1-o0.bc
#$LLVM_BIN/clang -O0 -c -emit-llvm  bitcnt_2.c -o bitcnt_2-o0.bc
#$LLVM_BIN/clang -O0 -c -emit-llvm  bitcnt_3.c -o bitcnt_3-o0.bc
#$LLVM_BIN/clang -O0 -c -emit-llvm  bitcnt_4.c -o bitcnt_4-o0.bc
#$LLVM_BIN/clang -O0 -c -emit-llvm  bitcnts.c -o bitcnts-o0.bc
#$LLVM_BIN/clang -O0 -c -emit-llvm  bitfiles.c -o bitfiles-o0.bc
#$LLVM_BIN/clang -O0 -c -emit-llvm  bitstrng.c -o bitstrng-o0.bc
#$LLVM_BIN/clang -O0 -c -emit-llvm  bstr_i.c -o bstr_i-o0.bc
#$LLVM_BIN/clang -O0 -c -emit-llvm  loop-wrap.c -o loop-wrap-o0.bc


#$LLVM_BIN/llvm-link bitarray-o0.bc bitcnt_1-o0.bc bitcnt_2-o0.bc bitcnt_3-o0.bc bitcnt_4-o0.bc bitcnts-o0.bc bitfiles-o0.bc bitstrng-o0.bc bstr_i-o0.bc loop-wrap-o0.bc -o output-o00.bc

$LLVM_BIN/llvm-link *.bc -o output-o0.bc
$LLVM_BIN/llvm-dis output-o0.bc -o output/$App_name/$App_name-noopt.ll


$LLVM_BIN/opt  -O3  -S output/$App_name/$App_name-noopt.ll -o output/$App_name/selected-IR/$App_name-noopt-o3.ll









