#!/bin/bash

# safe to modify for personal preference of quetness
THRESHOLD_FAN_ACTIVE=50         # above this much celsius fun is on, below this fan is off

# dont modify this
THRESHOLD_DEBOUNCE=5            # 5 degree error toelrance to prevent constant off/on of fan
THRESHOLD_FAN_SILENT=$(($THRESHOLD_FAN_ACTIVE - $THRESHOLD_DEBOUNCE))
TEMP_VALUES_DECIMAL_SPACES_MULTIPLYER=1000

while true
do
    #read GPU temp
    CURRENT_TEMP=$(cat /sys/class/drm/card0/device/hwmon/hwmon0/temp1_input)
    CURRENT_TEMP=$(($CURRENT_TEMP / $TEMP_VALUES_DECIMAL_SPACES_MULTIPLYER))
    
    # print info
    echo "ACTIVE:"
    echo $THRESHOLD_FAN_ACTIVE

    echo ""
    echo "INACTIVE"
    echo $THRESHOLD_FAN_SILENT
    
    echo ""
    echo "CURRENT:"
    echo $CURRENT_TEMP
    # done with info

    # if temp > 50 switch to auto
    if [ $CURRENT_TEMP -gt $THRESHOLD_FAN_ACTIVE ]
    then
        echo ""
        echo "should switch to auto, temp over threshold"
        echo 2 > /sys/class/drm/card0/device/hwmon/hwmon0/pwm1_enable
        sleep 120
    elif [ $CURRENT_TEMP -lt $THRESHOLD_FAN_SILENT ]
    then
        echo ""
        echo "shuld switch to silent, temperature unter threshold"
        echo 1 > /sys/class/drm/card0/device/hwmon/hwmon0/pwm1_enable
        echo 0  > /sys/class/drm/card0/device/hwmon/hwmon0/pwm1
    fi
    
    sleep 10
    
done
