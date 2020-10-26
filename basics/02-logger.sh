#!/bin/bash

#set HIDDEN_PATH:=$HOME

HIDDEN_PATH=.

currentDate=`date +%s`
echo -e $USER '\t' $currentDate >> "$HIDDEN_PATH/login_data.txt"
tail -n 10 "$HIDDEN_PATH/login_data.txt" > "$HIDDEN_PATH/login2_data.txt"
mv "$HIDDEN_PATH/login2_data.txt" "$HIDDEN_PATH/login_data.txt"
 
