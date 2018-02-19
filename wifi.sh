#!/bin/bash

file="$1"
while IFS= read -r line
do
		sudo service NetworkManager stop
		ip link set wlp3s0 down
		ip link set wlp3s0 address "$line"
		ip link set wlp3s0 up
		service NetworkManager start
		sleep 12
		list=`sudo ping -i 0.1 -s 1 -w 1 -c 5 ya.ru | grep ttl`
		if [ "$list" != "" ]; then
			echo "$line"
		else
			echo Not found
		fi

done <"$file"

