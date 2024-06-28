#!/usr/bin/bash
touch memoryram.txt
touch memoryram.csv
macaddress=$(ip -o link show dev eno1 | grep -Po 'ether \K[^ ]*')
dateinfo=$(date)
touch "updatedmemoryram_${macaddress}.csv"
free -m -h | cat > memoryram.txt
awk '{OFS=","};NR>1 {print $1,$2,$3,$4,$5}' memoryram.txt > memoryram.csv
awk -v data="$dateinfo" -F"," 'BEGIN{OFS = ","}{$7=data; print}' memoryram.csv > "updatedmemoryram_${macaddress}.csv"
cat "updatedmemoryram_${macaddress}.csv"
