#!/usr/bin/bash
macaddress=$(ip -o link show dev eno1 | grep -Po 'ether \K[^ ]*')
touch allinfile_${macaddress}.txt

totalcpu=$(top -bn2 | grep "Cpu(s)" | awk '{print $2+$4}' | cat | awk 'NR>1 {print $1}')
totalram=$(free -h | awk '{print $3}' | tr -d 'fre, ' | sed 's/ //g' | awk 'NR<3 {print $1}')
totaldisk=$(df -m | awk '{sum+=$5;} END{print sum;}')
echo The cpu usage is $totalcpu, the total ram usage is $totalram, the total disk usage is $totaldisk. >> allinfile_${macaddress}.txt
cat allinfile_${macaddress}.txt
