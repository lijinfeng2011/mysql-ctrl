#!/bin/bash

VERSION=$1
UUID=$2

if [ "X$UUID" == "X" ];then
    echo $0 version UUID
    exit 1 
fi

mkdir -p /data/mysql/$UUID
cp ../mysql-$VERSION/* /data/mysql/$UUID/

sed -i "s/_UUID_/$UUID/"  /data/mysql/$UUID/docker-compose.yaml

PORT=$(echo 3306+$UUID-1|bc)
echo PORT:$PORT

sed -i "s/_PORT_/$PORT/"  /data/mysql/$UUID/docker-compose.yaml

PASSWORD=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c12; echo)

sed -i "s/_PASSWORD_/$PASSWORD/"  /data/mysql/$UUID/docker-compose.yaml
