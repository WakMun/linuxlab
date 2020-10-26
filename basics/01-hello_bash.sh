#!/bin/bash
echo Welcome, $USER!
echo -----------------------
echo You are a member to the following groups:
groups | tr " " "\n" | sort | tr "\n" " " ; echo
echo -----------------------
currentDate=`date`
echo "Right now, it's" $currentDate


 
