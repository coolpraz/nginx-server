#!/usr/bin/env bash

# awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd
# awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/group

# userdel -r <user>

# cuser=$(awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd)

# echo ${cuser}