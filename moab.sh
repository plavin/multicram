#!/bin/bash

#MSUB -l partition=catalyst
#MSUB -l nodes=3
#MSUB -l walltime=1:00
#MSUB -l gres=ignore
#MSUB -q pbatch
#MSUB -j oe

#MSUB -N multicram

srun -n12 --multi-prog $(PWD)/multi.conf
