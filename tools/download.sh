#!/bin/bash

HOST=$1
USER=$2
PASSWORD=$3

UUID=$4
if [ "X$UUID" == "X" ];then
    echo $0 host user password uuid
    exit 1 
fi

mkdir -p tmp/$UUID

echo "show databases;"|mysql -h"$HOST" -p"$PASSWORD"  -u"$USER"  |sed 1d|grep -v ^information_schema$|grep -v ^performance_schema$|grep -v ^sys$|grep -v ^mysql$|xargs -i{} bash -c "mysqldump  -h"$HOST" -p"$PASSWORD"  -u"$USER" {} --single-transaction > tmp/$UUID/{}.sql"
