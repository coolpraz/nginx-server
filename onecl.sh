#!/usr/bin/env bash

# awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd
# awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/group

# userdel -r <user>

# cuser=$(awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd)

# echo ${cuser}

service=apache2

if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
echo "$service is running!!!"
else
echo "$service is not running!!!"
fi