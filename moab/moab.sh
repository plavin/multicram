#!/bin/bash

#MSUB -l partition=cab
#MSUB -l nodes=2
#MSUB -l walltime=1:00
#MSUB -l gres=ignore
#MSUB -q pdebug
#MSUB -j oe

#MSUB -N multicram

srun -n8 --multi-prog /g/g19/lavin2/multicram/multi.conf
##srun -n8 /g/g19/lavin2/multicram/bin/hello
##mpirun -n 4 /g/g19/lavin2/multicram/bin/hello : -n 4 /g/g19/lavin2/multicram/bin/hello2