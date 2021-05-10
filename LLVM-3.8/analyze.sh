#!/bin/bash
############executing files############
#############matrix-mult##################
App_name="bzip2d"

 for k in output/$App_name/exe-time/*
  do
    fname=`basename $k`
count=0;
total=0; 
for i in $( awk '{ print $1; }' $k )
   do 
     total=$(echo $total+$i | bc )
     ((count++))
   done
avg=$(echo "scale=4; $total / $count" | bc)
echo "$App_name-$fname", $avg  >> final-$App_name.csv
   echo "$fname-done"
    done





 


