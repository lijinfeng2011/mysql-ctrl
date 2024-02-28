#!/bin/bash
DIR=$1
UUID=$2

if [ "X$UUID" == "X" ];then
    echo $0 data-dir UUID
    exit 1 
fi

PASSWORD=$(./password.sh $UUID)
docker exec mysql-$UUID mkdir -p /tmp/m
ls $DIR |grep \.sql$|sed 's/.sql$//'|xargs -i{} bash -c "docker cp $DIR/{}.sql mysql-$UUID:/tmp/m/{}.sql"

ls $DIR |grep \.sql$|sed 's/.sql$//'|xargs -i{} bash -c "docker exec mysql-$UUID bash -c \"mysql -uroot -h127.0.0.1 -p'$PASSWORD'  -e 'CREATE DATABASE IF NOT EXISTS \\\`{}\\\`;'\""

ls $DIR |grep \.sql$|sed 's/.sql$//'|xargs -i{} bash -c "docker exec mysql-$UUID bash -c \"mysql -uroot -h127.0.0.1 -p'$PASSWORD'  {} < /tmp/m/{}.sql\""


docker exec mysql-$UUID rm -f /tmp/m/*.sql
