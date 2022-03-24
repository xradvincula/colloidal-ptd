#!/bin/bash

# this script generates $RUN plumed files to generate different cn.dat outputs

PLUMED_DIR=./plumed-automation
PLUMED_TMPL=$PLUMED_DIR/plumed.template.dat
LAMMPS_TMPL="$PLUMED_DIR/in.3Dcolloid.template"

RANDOM_NUMS=""
TOTAL_RUNS=$1
INIT_CONFIG_FILE=$2

j=0
while [ $j -ne $TOTAL_RUNS ]
do
	j=$(($j+1))
	# gen random number
	RANDOM_NUMS="$RANDOM_NUMS $RANDOM"
done
DOLLAR='$'
export TOTAL_RUNS RANDOM_NUMS INIT_CONFIG_FILE DOLLAR
envsubst < $LAMMPS_TMPL > "$PLUMED_DIR/in.3Dcolloid"
printf ">==\n$(date)\n$RANDOM_NUMS \n" >> run-seeds

i=0
while [ $i -ne $TOTAL_RUNS ]
do
	i=$(($i+1))
	# gen plumed data files
	RUN=$i
	export RUN
	envsubst < $PLUMED_TMPL > $PLUMED_DIR/plumed.$RUN.dat
done
echo $RANDOM_NUMS
