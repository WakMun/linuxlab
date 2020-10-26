#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Wrong Usage."
    exit 0
fi

if [ $# -gt 2 ]; then
    echo "Wrong Usage."
    exit 0
fi

shopt -s nocasematch
case "$1" in
    "start" )
        if [ $# -lt 2 ]; then
            echo "Wrong Usage."
            exit 0
        fi
        echo "starting..."
        bash blinkLED.sh $2 &
        echo $! > status.txt
        echo $2 >> status.txt
    ;;
    
    "stop" )
        if [ -e status.txt ]; then
            echo "stopping..."
            PID=`head -n 1 status.txt`
            FREQ=`tail -n 1 status.txt`
            kill  $PID
            rm status.txt
        else
            echo "Not blinking currently."
        fi
    ;;
    
    "status" )
        if [ -e status.txt ]; then
            PID=`head -n 1 status.txt`
            FREQ=`tail -n 1 status.txt`
            echo "Currently blinking with a period of $FREQ ms."
        else
            echo "Not blinking currently."
        fi
    ;;
    
    "teardown" )
        if [ -e status.txt ]; then
            echo "tearing down..."
            PID=`head -n 1 status.txt`
            FREQ=`tail -n 1 status.txt`
            kill  $PID
            rm status.txt
        else
            echo "Not blinking currently."
        fi
    ;;
    
    "faster" )
        if [ -e status.txt ]; then
            echo "making faster..."
            PID=`head -n 1 status.txt`
            FREQ=`tail -n 1 status.txt`
            NEWFREQ=`echo 3k $FREQ 100 -p | dc`
            kill  $PID
            rm status.txt
            bash blinkLED.sh $NEWFREQ &
            echo $! > status.txt
            echo $NEWFREQ >> status.txt
        else
            echo "Not blinking currently."
        fi
    ;;
    
    "slower" )
        if [ -e status.txt ]; then
            echo "making slower..."
            PID=`head -n 1 status.txt`
            FREQ=`tail -n 1 status.txt`
            NEWFREQ=`echo 3k $FREQ 100 +p | dc`
            kill  $PID
            rm status.txt
            bash blinkLED.sh $NEWFREQ &
            echo $! > status.txt
            echo $NEWFREQ >> status.txt
            
        else
            echo "Not blinking currently."
        fi
    ;;
    
    
    *)
        echo "Invalid command."
    ;;
esac