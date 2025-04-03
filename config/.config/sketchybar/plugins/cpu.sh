#!/bin/zsh

ncpu=$(sysctl -n machdep.cpu.thread_count)
cpu_info=$(ps -eo pcpu,user)
# cpu_sys=$(echo $cpu_info | awk -v ncpu=$ncpu -v user=$USER '{ if ($2 != user) sum+=$1 } END {print sum/ncpu}')
# cpu_user=$(echo $cpu_info | awk -v ncpu=$ncpu -v user=$USER '{ if ($2 == user) sum+=$1 } END {print sum/ncpu}')
cpu_total=$(echo $cpu_info | awk -v ncpu=$ncpu '{ sum += $1 } END {printf("%2d\n", sum / ncpu)}')

sketchybar --set cpu label=$cpu_total%
