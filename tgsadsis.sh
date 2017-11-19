#!/bin/bash

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
