#!/usr/bin/bash
touch storage.txt
touch storage.csv
macaddress=$(ip -o link show dev eno1 | grep -Po 'ether \K[^ ]*')
touch "updatedstorage3_${macaddress}.csv"
dateinfo=$(date)

df -m | grep t | cat> storage.txt
awk '{OFS=","};NR>1 {print $1,$2,$3,$4,$5,$NF}' storage.txt > storage.csv
awk -v data="$dateinfo" -F"," 'BEGIN{OFS = ","}{$7=data; print}' storage.csv > "updatedstorage_${macaddress}.csv"
touch "sysname_${macaddress}.txt"
touch "overallstorage_${macaddress}.txt"
touch "amountused_${macaddress}.txt"
touch "amountavailable_${macaddress}.txt"
touch "usage_${macaddress}.txt"
touch "location_${macaddress}.txt"
touch "date_${macaddress}.txt"

awk 'NR>1 {print $1}' storage.txt > "sysname_${macaddress}.txt"
awk 'NR>1 {print $2}' storage.txt > "overallstorage_${macaddress}.txt"
awk 'NR>1 {print $3}' storage.txt > "amountused_${macaddress}.txt"
awk 'NR>1 {print $4}' storage.txt > "amountavailable_${macaddress}.txt"
awk 'NR>1 {print $5}' storage.txt > "usage_${macaddress}.txt"
awk 'NR>1 {print $6}' storage.txt > "location_${macaddress}.txt"
awk -F"," 'NR>1 {print $7}' "updatedstorage_${macaddress}.csv" > "date_${macaddress}.txt" 

