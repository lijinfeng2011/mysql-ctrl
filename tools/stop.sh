#!/bin/bash

UUID=$1

if [ "X$UUID" == "X" ];then
    echo $0 version UUID
    exit 1 
fi

cd /data/mysql/$UUID/ && docker-compose down

