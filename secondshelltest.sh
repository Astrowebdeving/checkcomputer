 #!/usr/bin/bash
touch storage3.txt
touch storage3.csv
macaddress=$(ip -o link show dev eno1 | grep -Po 'ether \K[^ ]*')
touch "updatedstorage3_${macaddress}.csv"
dateinfo=$(date)

top -bn 1 | sed -n '/PID/,$p' | grep -v top | grep s |  cat > storage3.txt
awk '{OFS=","};NR>1 {print $1,$2,$3,$9,$10,$13}' storage3.txt > storage3.csv
awk -v data="$dateinfo" -F"," 'BEGIN{OFS = ","}{$7=data; print}' storage3.csv > "updatedstorage3_${macaddress}.csv"
touch "sPID_${macaddress}.txt"
touch "userfound_${macaddress}.txt"
touch "PRstoring_${macaddress}.txt"
touch "cpupercentage_${macaddress}.txt"
touch "mempercentage_${macaddress}.txt"
touch "location3_${macaddress}.txt"
touch "date3_${macaddress}.txt"
awk 'NR>1 {print $1}' storage3.txt > "sPID_${macaddress}.txt"
awk 'NR>1 {print $2}' storage3.txt > "userfound_${macaddress}.txt"
awk 'NR>1 {print $3}' storage3.txt > "PRstoring_${macaddress}.txt"
awk 'NR>1 {print $4}' storage3.txt > "cpupercentage_${macaddress}.txt"
awk 'NR>1 {print $5}' storage3.txt > "mempercentage_${macaddress}.txt"
awk 'NR>1 {print $6}' storage3.txt > "location3_${macaddress}.txt"
awk -F"," 'NR>1 {print $7}' "updatedstorage3_${macaddress}.csv" > "date3_${macaddress}.txt"


