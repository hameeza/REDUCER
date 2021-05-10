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
#############length 1###########
mkdir output/$App_name/generation1
for i in {1..5} ####################optimization length
 do
  var_name="cluster_$i"
  var_name2="clustopt_$i"
  actual_name="clusteractual_$i"
  actual_name2="clustact_$i"
  eval ${var_name2}='${!var_name}'
  eval ${actual_name2}='${!actual_name}'
  echo ${!var_name2}
  $LLVM_BIN/opt ${!actual_name2}  $orig_ir_name -S -o output/$App_name/generation1/output-test-${!var_name2}.ll
status="0"
md5=$(md5sum < "output/$App_name/generation1/output-test-${!var_name2}.ll")
if [[ $(grep -L "$md5" "match.csv") ]];
then 
echo "$md5" >> match.csv 
echo "${!var_name2}" >> opt-name
fi
rm output/$App_name/generation1/output-test-${!var_name2}.ll
  done
rmdir output/$App_name/generation1

##############length 2###############
mkdir output/$App_name/generation2
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
  eval ${var_name2}='${!var_name}' 
  eval ${var_name2}+='${!var_name3}' 
  eval ${actual_name2}='${!actual_name}' 
  eval ${actual_name2}+='${!actual_name3}' 
  echo ${!var_name2}
 $LLVM_BIN/opt ${!actual_name2}  $orig_ir_name -S -o output/$App_name/generation2/output-test-${!var_name2}.ll
md5=$(md5sum < "output/$App_name/generation2/output-test-${!var_name2}.ll")

if [[ $(grep -L "$md5" "match.csv") ]];
then 
echo "$md5" >> match.csv 
echo "${!var_name2}" >> opt-name
fi
rm output/$App_name/generation2/output-test-${!var_name2}.ll
done
done
rmdir output/$App_name/generation2

#############length 3############
mkdir output/$App_name/generation3
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
  eval ${var_name2}='${!var_name}' 
  eval ${var_name2}+='${!var_name3}' 
  eval ${var_name2}+='${!var_name4}'
  eval ${actual_name2}='${!actual_name}' 
  eval ${actual_name2}+='${!actual_name3}' 
  eval ${actual_name2}+='${!actual_name4}'  
  echo ${!var_name2}
$LLVM_BIN/opt ${!actual_name2}  $orig_ir_name -S -o output/$App_name/generation3/output-test-${!var_name2}.ll
md5=$(md5sum < "output/$App_name/generation3/output-test-${!var_name2}.ll")

if [[ $(grep -L "$md5" "match.csv") ]];
then 
echo "$md5" >> match.csv 
echo "${!var_name2}" >> opt-name
fi
rm output/$App_name/generation3/output-test-${!var_name2}.ll
  done
done
done
rmdir output/$App_name/generation3

#############length 4#############
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
$LLVM_BIN/opt ${!actual_name2}  $orig_ir_name -S -o output/$App_name/generation4/output-test-${!var_name2}.ll
md5=$(md5sum < "output/$App_name/generation4/output-test-${!var_name2}.ll")

if [[ $(grep -L "$md5" "match.csv") ]];
then 
echo "$md5" >> match.csv 
echo "${!var_name2}" >> opt-name
fi
rm output/$App_name/generation4/output-test-${!var_name2}.ll
  done
done
done
done
rmdir output/$App_name/generation4

###############length 5################
mkdir output/$App_name/generation5
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
  var_name5="cluster_$l"
  actual_name5="clusteractual_$l"
 for m in {1..5}
  do
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
$LLVM_BIN/opt ${!actual_name2}  $orig_ir_name -S -o output/$App_name/generation5/output-test-${!var_name2}.ll
md5=$(md5sum < "output/$App_name/generation5/output-test-${!var_name2}.ll")

if [[ $(grep -L "$md5" "match.csv") ]];
then 
echo "$md5" >> match.csv 
echo "${!var_name2}" >> opt-name
fi
rm output/$App_name/generation5/output-test-${!var_name2}.ll
  done
done
done
done
done
rmdir output/$App_name/generation5

##############length 6###########
mkdir output/$App_name/generation6
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
  var_name5="cluster_$l"
  actual_name5="clusteractual_$l"
 for m in {1..5}
  do
  var_name6="cluster_$m"
  actual_name6="clusteractual_$m"
  for n in {1..5}
  do
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
$LLVM_BIN/opt ${!actual_name2}  $orig_ir_name -S -o output/$App_name/generation6/output-test-${!var_name2}.ll
md5=$(md5sum < "output/$App_name/generation6/output-test-${!var_name2}.ll")

if [[ $(grep -L "$md5" "match.csv") ]];
then 
echo "$md5" >> match.csv 
echo "${!var_name2}" >> opt-name
fi
rm output/$App_name/generation6/output-test-${!var_name2}.ll
  done
done
done
done
done
done
rmdir output/$App_name/generation6
