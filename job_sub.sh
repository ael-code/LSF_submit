#!/bin/bash

job_template(){
    cat <<-EOF
		#BSUB -J ${name="NAME"}
		#BSUB -oo ${out_folder:-"out/"}${name}_%J.out

		#BSUB -q ${queue:-"debug"}
		#BSUB -W ${time_limit:-"00:01"}

		#BSUB -n ${pnum:-1}
		#BSUB -R"span[ptile=${p4node:-$pnum}]"
		#BSUB -x

		${exe:-"CMD_TO_EXE"}
	EOF
}

submit(){
	if [ -z ${TEST} ]; then
		job_template | bsub
	else
		job_template
	fi
}


name="job_name"
exe="echo 'some heavy work'"
#pnum=1
#p4node=1
#queue="debug"
#time_limit="00:01"


#for i in 1 2 4 8 16; do
#	for j in `seq 1`; do
		submit
#	done
#done
