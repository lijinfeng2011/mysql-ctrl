#!/bin/bash

UUID=$1

if [ "X$UUID" == "X" ];then
    echo $0 UUID
    exit 1 
fi

PASSWORD=$(./password.sh $UUID)
echo password:$PASSWORD

exec docker exec -it mysql-$UUID bash -c "mysql -uroot -h127.0.0.1 -p'$PASSWORD' --get-server-public-key"

