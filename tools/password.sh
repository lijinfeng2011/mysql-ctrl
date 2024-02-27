#!/bin/bash

UUID=$1

if [ "X$UUID" == "X" ];then
    echo $0 version UUID
    exit 1 
fi

cat /data/mysql/$UUID/docker-compose.yaml |grep MYSQL_ROOT_PASSWORD:|awk '{print $2}'
