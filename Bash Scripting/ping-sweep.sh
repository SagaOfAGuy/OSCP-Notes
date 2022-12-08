#!/bin/bash

for ip in $(seq $2 $3);do
        ping -c1 $1.$ip|grep -q '1 packets received' && echo $1.$ip
done
