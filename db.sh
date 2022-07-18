#!/usr/bin/env bash

status=1
while [[ $status -eq 1 ]]
do
echo -en '\033[1;33mВведите наименование базы данных \033[0m \n'
        read A
echo -en '\033[1;33mПодтвердите... \033[0m \n'
        read B
if [ $A = $B ]
then
echo -en '\033[1;33mПодтвержденно \033[0m \n'
status=0
C=$B
else
echo -en '\033[1;33mНе совпадают \033[0m \n'
status=1
fi
done
mysql -uroot -p --execute="create database "$C" ;"
echo $C

