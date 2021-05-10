#!/bin/bash
LLVM_BIN=/home/hameeza/Downloads/Downloads/clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-16.04/bin
export LD_LIBRARY_PATH=/home/hameeza/Downloads/Downloads/clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-16.04/lib:$LD_LIBRARY_PATH
############executing files############
#############matrix-mult##################
App_name="bzip2d"
dataset="output/$App_name/Dataset"

 for k in output/$App_name/exe-files/*
   do
   for i in {1..3}
    do 
     fname=`basename $k`
     mytime="$( /usr/bin/time -f "%e" ./$k -d -k -f -c $dataset/1.bz2  2>&1 1>/dev/null ) "
     echo $mytime >> output/$App_name/exe-time/$fname
     echo "$fname-done"
    done
   done

 


