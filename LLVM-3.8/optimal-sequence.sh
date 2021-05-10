#!/bin/bash
LLVM_BIN=/home/hameeza/Downloads/Downloads/clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-16.04/bin
App_name="bzip2d"

#########################5 Clusters################################

###################Agglerometric#####################

clusteractual_1=" -ipsccp -globalopt -deadargelim -simplifycfg -functionattrs -argpromotion -sroa -jump-threading -reassociate -indvars     -mldst-motion -lcssa -rpo-functionattrs -bdce -dse -inferattrs -prune-eh -alignment-from-assumptions -barrier -block-freq -loop-unswitch -branch-prob -demanded-bits -float2int -forceattrs -loop-idiom -globals-aa -gvn -loop-accesses -loop-deletion -loop-unroll -loop-vectorize   -sccp -strip-dead-prototypes -inline -globaldce -constmerge" ###A
clusteractual_2=" -licm -mem2reg" ###B
clusteractual_3=" -loop-rotate -instcombine -loop-simplify" ###C
clusteractual_4=" -memcpyopt" ###D
clusteractual_5=" -loop-unswitch -adce -slp-vectorizer -tailcallelim" ###E

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


  var_name="cluster_3"
  var_name2="clustopt_3"
  actual_name="clusteractual_3"
  actual_name2="clustact_3"

  var_name3="cluster_2"
  actual_name3="clusteractual_2"

  var_name4="cluster_4"
  actual_name4="clusteractual_4"

  var_name5="cluster_1"
  actual_name5="clusteractual_1"
 
  var_name6="cluster_3"
  actual_name6="clusteractual_3"

  var_name7="cluster_1"
  actual_name7="clusteractual_1"

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
  echo ${!actual_name2}


$LLVM_BIN/opt ${!actual_name2}  $orig_ir_name -S -o output/$App_name/optimal-sequence/output-test-${!var_name2}.ll

   for kk in output/$App_name/selected-IR/*
   do 
   if cmp -s "$kk" "output/$App_name/optimal-sequence/output-test-${!var_name2}.ll"; then
   echo "matched IR name is $kk "
   break 
   fi
   done




