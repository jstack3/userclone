# SCRIPT NAME: cloneuser.sh
# PURPOSE: clone a new system user, an exact copy of another one 
#(having the same groups, permissions, privileges and settings), 
# but with a different username, password and home directory
#!/bin/bash
# VARIABLE ASSIGNMENT
SRC=$1
DEST=$2
SRC_GROUPS=$(id -Gn "$SRC" | sed "s/ /,/g" | sed -r 's/\<'"$SRC"'\>\b,?//g')
SRC_SHELL=$(awk -F : -v name="$SRC" '(name == $1) { print $7 }' /etc/passwd) 
# adds user and requests new password
sudo useradd --groups "$SRC_GROUPS" --shell "$SRC_SHELL" --create-home "$DEST"
sudo passwd "$DEST"   


