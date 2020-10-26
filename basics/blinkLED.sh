#!/bin/bash

# Common path for all GPIO access
BASE_GPIO_PATH=/sys/class/gpio

# Assign names to GPIO pin numbers for each light
RED=23

# Assign names to states
ON="1"
OFF="0"

# Utility function to export a pin if not already exported
exportPin()
{
  
  if [ ! -e $BASE_GPIO_PATH/gpio$1 ]; then
    echo "$1" > $BASE_GPIO_PATH/export
  fi
}

# Utility function to unexport a pin if not already exported
unexportPin()
{
  if [ -e $BASE_GPIO_PATH/gpio$1 ]; then
    echo "$1" > $BASE_GPIO_PATH/unexport
  fi
}

# Utility function to set a pin as an output
setOutput()
{
  echo "out" > $BASE_GPIO_PATH/gpio$1/direction
}

# Utility function to change state of a light
setLightState()
{
  echo $2 > $BASE_GPIO_PATH/gpio$1/value
}

# Utility function to turn all lights off
allLightsOff()
{
  setLightState $RED $OFF
}

# Ctrl-C handler for clean shutdown
shutdown()
{
  allLightsOff
  unexportPin $RED
  exit 0
}

trap shutdown SIGINT

# Export pins so that we can use them
exportPin $RED

# Set pins as outputs
setOutput $RED

# Turn lights off to begin
allLightsOff

#Calculate the sleep time based on cmd line args
SLEEP_SEC=`echo 3k $1 1000 /p | dc`

# Loop forever until user presses Ctrl-C
while [ 1 ]
do
  # Red
  setLightState $RED $ON
  sleep $SLEEP_SEC
  setLightState $RED $OFF
  sleep $SLEEP_SEC
done