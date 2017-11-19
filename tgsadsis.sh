#!/bin/bash

networkSpeed () {

read -p 'Interface (ex: eth0, etc): ' data

while true
do
	R1=`cat /sys/class/net/$data/statistics/rx_bytes`
	T1=`cat /sys/class/net/$data/statistics/tx_bytes`
	sleep 1
	R2=`cat /sys/class/net/$data/statistics/tx_bytes`
	T2=`cat /sys/class/net/$data/statistics/tx_bytes`
	TBPS=`expr $T2 - $T1`
	RBPS=`expr $R2 - $R1`
	TKBPS=`expr $TBPS / 1024`
	RKBPS=`expr $RBPS / 1024`
	echo "tx $1: $TKBPS kb/s rx $1: RKBPS kb/s"
done

}

monitorSystem () {
printf "Memory\t\tDisk\t\tCPU\n"
SECONDS=$(date +'%S')
end=$((SECONDS+3600))
while [ $SECONDS -lt $end ];
do
	m=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
	d=$(df -h | awk 'NR==2{printf "%s\t\t", $5}')
	c=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
	echo "$m$d$c"
sleep 1
done
}

echo "=========================================\n"
echo "	TEST NETWORK SPEED & MONITOR SYSTEM	\n"
echo "=========================================\n"
echo "1. TEST NETWORK SPEED\n"
echo "2. MONITOR SYSTEM\n"
echo "3. EXIT\n"
echo "Choose one: "
read pilih

