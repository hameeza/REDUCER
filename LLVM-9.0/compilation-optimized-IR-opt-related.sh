#!/bin/bash
LLVM_BIN=/home/hameeza/Documents/clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-18.04/bin
App_name="bzip2d"

#########################5 Clusters################################

###################Agglerometric#####################

clusteractual_1=" -tti -targetlibinfo -tbaa -scoped-noalias -assumption-cache-tracker -profile-summary-info -forceattrs -inferattrs -callsite-splitting -ipsccp -called-value-propagation -attributor -globalopt -mem2reg -deadargelim -lazy-block-freq -prune-eh -inline -functionattrs -argpromotion -memoryssa -lazy-value-info -jump-threading -libcalls-shrinkwrap -branch-prob -reassociate -loop-simplify -lcssa-verification -loop-rotate -indvars -loop-idiom -loop-deletion -mldst-motion -gvn -memcpyopt -sccp -dse -postdomtree -barrier -float2int -loop-distribute -loop-vectorize -slp-vectorizer -transform-warning -alignment-from-assumptions -strip-dead-prototypes -constmerge -instsimplify" ###A
clusteractual_2=" -aa -loops -lazy-branch-prob -block-freq -licm -loop-unroll -memdep -demanded-bits -loop-accesses -loop-sink" ###B
clusteractual_3=" -instcombine -simplifycfg -tailcallelim -loop-unswitch -adce -div-rem-pairs" ###C
clusteractual_4=" -domtree -basicaa -sroa -early-cse-memssa -correlated-propagation -aggressive-instcombine -pgo-memop-opt -lcssa -scalar-evolution -phi-values -bdce -loop-load-elim" ###D
clusteractual_5=" -basiccg -globals-aa -elim-avail-extern -rpo-functionattrs -globaldce" ###E

##############Following Names used for printing##################
cluster_1="A_"
cluster_2="B_"
cluster_3="C_"
cluster_4="D_"
cluster_5="E_"


orig_ir_name="output/$App_name/$App_name-noopt.ll"



#["0['-indvars', '-assumption-cache-tracker', '-dse', '-loop-distribute', '-ipsccp', '-profile-summary-info', '-callsite-splitting', '-instsimplify', '-div-rem-pairs', '-mem2reg', '-globalopt', '-scoped-noalias', '-jump-threading', '-tti', '-basiccg', '-globaldce', '-loop-unswitch', '-argpromotion', '-targetlibinfo', '-attributor', '-loop-deletion', '-forceattrs', '-loop-unroll', '-correlated-propagation', '-called-value-propagation', '-alignment-from-assumptions', '-lazy-value-info', '-branch-prob', '-memcpyopt', '-deadargelim', '-globals-aa', '-rpo-functionattrs', '-functionattrs', '-strip-dead-prototypes', '-loop-idiom', '-transform-warning', '-tbaa', '-reassociate', '-slp-vectorizer', '-prune-eh', '-inline', '-elim-avail-extern', '-lazy-block-freq', '-adce', '-simplifycfg', '-libcalls-shrinkwrap', '-sccp', '-instcombine', '-tailcallelim', '-float2int', '-barrier', '-inferattrs', '-constmerge']", "1['-memoryssa', '-loop-load-elim', '-phi-values', '-basicaa', '-mldst-motion', '-gvn', '-aggressive-instcombine', '-scalar-evolution', '-sroa', '-early-cse-memssa', '-bdce', '-domtree', '-pgo-memop-opt']", "2['-opt-remark-emitter']", "3['-demanded-bits', '-lcssa', '-block-freq', '-loop-vectorize', '-postdomtree', '-memdep', '-lcssa-verification', '-loop-accesses', '-licm', '-loop-simplify', '-loops', '-loop-sink', '-lazy-branch-prob', '-loop-rotate']", "4['-aa']"]


#######ABCDEA

###################Length 1 ##################
total=0
clustopt_1=""
clustopt_2=""
clustopt_3=""
clustopt_4=""
clustopt_5=""

clustact_1=""
clustact_2=""
clustact_3=""
clustact_4=""
clustact_5=""
##echo "============length 1"
mkdir output/$App_name/generation1
for i in {1..5} ####################optimization length
 do
# # echo $i
  var_name="cluster_$i"
  var_name2="clustopt_$i"
  actual_name="clusteractual_$i"
  actual_name2="clustact_$i"
  eval ${var_name2}='${!var_name}'
  eval ${actual_name2}='${!actual_name}'
  echo ${!var_name2}
#  # echo ${!actual_name2}


  $LLVM_BIN/opt ${!actual_name2}  $orig_ir_name -S -o output/$App_name/generation1/output-test-${!var_name2}.ll
status="0"
## echo $status


md5=$(md5sum < "output/$App_name/generation1/output-test-${!var_name2}.ll")

if [[ $(grep -L "$md5" "match.csv") ]];
#grep -q -F $md5 match.csv
#if [ $? -ne 0]; then
then 
#echo "not"
#mv output/$App_name/generation1/output-test-${!var_name2}.ll output/$App_name/selected-IR/output-test-${!var_name2}.ll; 
echo "$md5" >> match.csv 
echo "${!var_name2}" >> opt-name
#grep -qxF "$md5" "match.csv" || echo "$md5" >> match.csv 
#else


fi
rm output/$App_name/generation1/output-test-${!var_name2}.ll

  done

rmdir output/$App_name/generation1


##echo "============length 2"
mkdir output/$App_name/generation2
for i in {1..5} ####################optimization length
 do
  var_name="cluster_$i"
  var_name2="clustopt_$i"
  actual_name="clusteractual_$i"
  actual_name2="clustact_$i"
# # echo $i
 for j in {1..5}
  do
#  # echo $j
  var_name3="cluster_$j"
  actual_name3="clusteractual_$j"
  eval ${var_name2}='${!var_name}' 
  eval ${var_name2}+='${!var_name3}' 
  eval ${actual_name2}='${!actual_name}' 
  eval ${actual_name2}+='${!actual_name3}' 
  echo ${!var_name2}
 # # echo ${!actual_name2}

 $LLVM_BIN/opt ${!actual_name2}  $orig_ir_name -S -o output/$App_name/generation2/output-test-${!var_name2}.ll


md5=$(md5sum < "output/$App_name/generation2/output-test-${!var_name2}.ll")

if [[ $(grep -L "$md5" "match.csv") ]];
#if ! grep -q "\"$md5\"" "match.csv";
then 
#echo "$md5" >> match.csv 
#fi

#grep -qxF "$md5" "match.csv" || echo "$md5" >> match.csv

#grep -q -F $md5 match.csv
#if [ $? -ne 0]; then
#then 
#mv output/$App_name/generation2/output-test-${!var_name2}.ll output/$App_name/selected-IR/output-test-${!var_name2}.ll; 
echo "$md5" >> match.csv 
echo "${!var_name2}" >> opt-name

#grep -qxF "$md5" "match.csv" || echo "$md5" >> match.csv 
#else


fi

rm output/$App_name/generation2/output-test-${!var_name2}.ll


done
done

rmdir output/$App_name/generation2


##echo "============length 3"
mkdir output/$App_name/generation3
for i in {1..5} ####################optimization length
 do
  var_name="cluster_$i"
  var_name2="clustopt_$i"
  actual_name="clusteractual_$i"
  actual_name2="clustact_$i"
 # echo $i
 for j in {1..5}
  do

  # echo $j
  var_name3="cluster_$j"
  actual_name3="clusteractual_$j"
  for k in {1..5}
  do
  # echo $k
  var_name4="cluster_$k"
  actual_name4="clusteractual_$k"
  eval ${var_name2}='${!var_name}' 
  eval ${var_name2}+='${!var_name3}' 
  eval ${var_name2}+='${!var_name4}'
  eval ${actual_name2}='${!actual_name}' 
  eval ${actual_name2}+='${!actual_name3}' 
  eval ${actual_name2}+='${!actual_name4}'  
  echo ${!var_name2}
  # echo ${!actual_name2}

$LLVM_BIN/opt ${!actual_name2}  $orig_ir_name -S -o output/$App_name/generation3/output-test-${!var_name2}.ll

# echo $status


md5=$(md5sum < "output/$App_name/generation3/output-test-${!var_name2}.ll")

if [[ $(grep -L "$md5" "match.csv") ]];
#if ! grep -q "\"$md5\"" "match.csv";
then 
#echo "$md5" >> match.csv 
#fi

#grep -q -F $md5 match.csv
#if [ $? -ne 0]; then
#then 
#mv output/$App_name/generation3/output-test-${!var_name2}.ll output/$App_name/selected-IR/output-test-${!var_name2}.ll; 
echo "$md5" >> match.csv 
echo "${!var_name2}" >> opt-name

#grep -qxF "$md5" "match.csv" || echo "$md5" >> match.csv 
#else


fi

rm output/$App_name/generation3/output-test-${!var_name2}.ll

#grep -qxF "$md5" "match.csv" || echo "$md5" >> match.csv 

#rm output/$App_name/generation3/output-test-${!var_name2}.ll



  done
done
done

rmdir output/$App_name/generation3

#echo "============length 4"
mkdir output/$App_name/generation4
for i in {1..5} ####################optimization length
 do
  var_name="cluster_$i"
  var_name2="clustopt_$i"
  actual_name="clusteractual_$i"
  actual_name2="clustact_$i"

 for j in {1..5}
  do
   var_name3="cluster_$j"
  actual_name3="clusteractual_$j"
  for k in {1..5}
  do
  var_name4="cluster_$k"
  actual_name4="clusteractual_$k"
  for l in {1..5}
  do

  # echo $l
  var_name5="cluster_$l"
  actual_name5="clusteractual_$l"
  eval ${var_name2}='${!var_name}' 
  eval ${var_name2}+='${!var_name3}' 
  eval ${var_name2}+='${!var_name4}' 
  eval ${var_name2}+='${!var_name5}' 
  eval ${actual_name2}='${!actual_name}' 
  eval ${actual_name2}+='${!actual_name3}' 
  eval ${actual_name2}+='${!actual_name4}' 
  eval ${actual_name2}+='${!actual_name5}' 
  echo ${!var_name2}
  # echo ${!actual_name2}


$LLVM_BIN/opt ${!actual_name2}  $orig_ir_name -S -o output/$App_name/generation4/output-test-${!var_name2}.ll


md5=$(md5sum < "output/$App_name/generation4/output-test-${!var_name2}.ll")

if [[ $(grep -L "$md5" "match.csv") ]];
#if ! grep -q "\"$md5\"" "match.csv";
then 
#echo "$md5" >> match.csv 
#fi

#grep -qxF "$md5" "match.csv" || echo "$md5" >> match.csv 

#grep -q -F $md5 match.csv
#if [ $? -ne 0]; then
#then 
#mv output/$App_name/generation4/output-test-${!var_name2}.ll output/$App_name/selected-IR/output-test-${!var_name2}.ll; 
echo "$md5" >> match.csv 
echo "${!var_name2}" >> opt-name

#grep -qxF "$md5" "match.csv" || echo "$md5" >> match.csv 
#else


fi

rm output/$App_name/generation4/output-test-${!var_name2}.ll







  done
done
done
done

rmdir output/$App_name/generation4


#echo "============length 5"
mkdir output/$App_name/generation5
for i in {1..5} ####################optimization length
 do
  var_name="cluster_$i"
  var_name2="clustopt_$i"
  actual_name="clusteractual_$i"
  actual_name2="clustact_$i"

 # echo $i
 for j in {1..5}
  do
 
  # echo $j
  var_name3="cluster_$j"
  actual_name3="clusteractual_$j"
  for k in {1..5}
  do

  # echo $k
  var_name4="cluster_$k"
  actual_name4="clusteractual_$k"
  for l in {1..5}
  do

  # echo $l
  var_name5="cluster_$l"
  actual_name5="clusteractual_$l"
 for m in {1..5}
  do
 
  # echo $m
  var_name6="cluster_$m"
  actual_name6="clusteractual_$m"
  eval ${var_name2}='${!var_name}' 
  eval ${var_name2}+='${!var_name3}' 
  eval ${var_name2}+='${!var_name4}' 
  eval ${var_name2}+='${!var_name5}' 
  eval ${var_name2}+='${!var_name6}'
  eval ${actual_name2}='${!actual_name}' 
  eval ${actual_name2}+='${!actual_name3}' 
  eval ${actual_name2}+='${!actual_name4}' 
  eval ${actual_name2}+='${!actual_name5}' 
  eval ${actual_name2}+='${!actual_name6}' 
  echo ${!var_name2}
  # echo ${!actual_name2}


$LLVM_BIN/opt ${!actual_name2}  $orig_ir_name -S -o output/$App_name/generation5/output-test-${!var_name2}.ll

md5=$(md5sum < "output/$App_name/generation5/output-test-${!var_name2}.ll")

if [[ $(grep -L "$md5" "match.csv") ]];
#if ! grep -q "\"$md5\"" "match.csv";
then 
#echo "$md5" >> match.csv 
#fi

#grep -qxF "$md5" "match.csv" || echo "$md5" >> match.csv 

#grep -q -F $md5 match.csv
#if [ $? -ne 0]; then
#then
#mv output/$App_name/generation5/output-test-${!var_name2}.ll output/$App_name/selected-IR/output-test-${!var_name2}.ll; 
echo "$md5" >> match.csv 
echo "${!var_name2}" >> opt-name

#grep -qxF "$md5" "match.csv" || echo "$md5" >> match.csv 
#else



fi

rm output/$App_name/generation5/output-test-${!var_name2}.ll


  done
done
done
done
done

rmdir output/$App_name/generation5



#echo "============length 6"
mkdir output/$App_name/generation6
for i in {1..5} ####################optimization length
 do
  var_name="cluster_$i"
  var_name2="clustopt_$i"
  actual_name="clusteractual_$i"
  actual_name2="clustact_$i"

 # echo $i

 for j in {1..5}
  do


  # echo $j

  var_name3="cluster_$j"
  actual_name3="clusteractual_$j"
  for k in {1..5}
  do


  # echo $k

  var_name4="cluster_$k"
  actual_name4="clusteractual_$k"
  for l in {1..5}
  do



  # echo $l

  var_name5="cluster_$l"
  actual_name5="clusteractual_$l"
 for m in {1..5}
  do



  # echo $m

  var_name6="cluster_$m"
  actual_name6="clusteractual_$m"
  for n in {1..5}
  do



  # echo $n

  var_name7="cluster_$n"
  actual_name7="clusteractual_$n"

  eval ${var_name2}='${!var_name}' 
  eval ${var_name2}+='${!var_name3}' 
  eval ${var_name2}+='${!var_name4}' 
  eval ${var_name2}+='${!var_name5}' 
  eval ${var_name2}+='${!var_name6}' 
  eval ${var_name2}+='${!var_name7}' 
  eval ${actual_name2}='${!actual_name}' 
  eval ${actual_name2}+='${!actual_name3}' 
  eval ${actual_name2}+='${!actual_name4}' 
  eval ${actual_name2}+='${!actual_name5}' 
  eval ${actual_name2}+='${!actual_name6}'
  eval ${actual_name2}+='${!actual_name7}'
  echo ${!var_name2}
  # echo ${!actual_name2}


$LLVM_BIN/opt ${!actual_name2}  $orig_ir_name -S -o output/$App_name/generation6/output-test-${!var_name2}.ll


md5=$(md5sum < "output/$App_name/generation6/output-test-${!var_name2}.ll")

if [[ $(grep -L "$md5" "match.csv") ]];
#if ! grep -q "\"$md5\"" "match.csv";
then 
#echo "$md5" >> match.csv 
#fi

#grep -qxF "$md5" "match.csv" || echo "$md5" >> match.csv 

#grep -q -F $md5 match.csv
#if [ $? -ne 0]; then
#then 
#mv output/$App_name/generation6/output-test-${!var_name2}.ll output/$App_name/selected-IR/output-test-${!var_name2}.ll; 
echo "$md5" >> match.csv 
echo "${!var_name2}" >> opt-name

#grep -qxF "$md5" "match.csv" || echo "$md5" >> match.csv 
#else


fi

rm output/$App_name/generation6/output-test-${!var_name2}.ll



  done
done
done
done
done
done

rmdir output/$App_name/generation6






