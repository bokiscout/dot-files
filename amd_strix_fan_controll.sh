#!/bin/bash

DEBUG=0

# safe to modify for personal preference of quetness
THRESHOLD_FAN_ACTIVE=60         # above this much celsius fun is on, below this fan is off or at low speed

# dont modify this
THRESHOLD_DEBOUNCE=5            # 5 degree error toelrance to prevent constant off/on of fan
THRESHOLD_FAN_SILENT=$(($THRESHOLD_FAN_ACTIVE - $THRESHOLD_DEBOUNCE -$THRESHOLD_DEBOUNCE -$THRESHOLD_DEBOUNCE))
THRESHOLD_FAN_VERY_LOW_SPEED=$(($THRESHOLD_FAN_ACTIVE - $THRESHOLD_DEBOUNCE - $THRESHOLD_DEBOUNCE))
THRESHOLD_FAN_LOW_SPEED=$(($THRESHOLD_FAN_ACTIVE - $THRESHOLD_DEBOUNCE))
TEMP_VALUES_DECIMAL_SPACES_MULTIPLYER=1000

# before anything set gpu clock to high performance
#echo high > /sys/class/drm/card0/device/power_dpm_force_performance_level

while true
do
    #read GPU temp
    CURRENT_TEMP=$(cat /sys/class/drm/card0/device/hwmon/hwmon0/temp1_input)
    CURRENT_TEMP=$(($CURRENT_TEMP / $TEMP_VALUES_DECIMAL_SPACES_MULTIPLYER))
    
    # print info
    if [ $DEBUG -gt 0 ]
    then
        echo "=========================================="
        echo ""
        echo "ACTIVE:"
        echo $THRESHOLD_FAN_ACTIVE

        echo ""
        echo "LOW SPEED"
        echo $THRESHOLD_FAN_LOW_SPEED
    
        echo ""
        echo "VERY LOW SPEED"
        echo $THRESHOLD_FAN_VERY_LOW_SPEED
    
        echo ""
        echo "INACTIVE"
        echo $THRESHOLD_FAN_SILENT
    
        echo ""
        echo "CURRENT:"
        echo $CURRENT_TEMP
        # done with info
    fi

    # if temp > THRESHOLD switch to auto
    if [ $CURRENT_TEMP -gt $THRESHOLD_FAN_ACTIVE ]
    then
        if [ $DEBUG -gt 0 ]
        then
            echo ""
            echo "should switch to auto, temperature above threshold"
        fi
        echo 2 > /sys/class/drm/card0/device/hwmon/hwmon0/pwm1_enable
        sleep 30
    elif [ $CURRENT_TEMP -gt $THRESHOLD_FAN_LOW_SPEED ]
    then
        if [ $DEBUG -gt 0 ]
        then
            echo ""
            echo "shuld switch to low speed, temperature around threshold"
        fi
        echo 1 > /sys/class/drm/card0/device/hwmon/hwmon0/pwm1_enable
        echo 90 > /sys/class/drm/card0/device/hwmon/hwmon0/pwm1             # +-900 RPM
    elif [ $CURRENT_TEMP -gt $THRESHOLD_FAN_VERY_LOW_SPEED ]
    then
        if [ $DEBUG -gt 0 ]
        then
            echo ""
            echo "shuld switch to very low speed, temperature around very lovest active threshold"
        fi
        echo 1 > /sys/class/drm/card0/device/hwmon/hwmon0/pwm1_enable
        echo 74 > /sys/class/drm/card0/device/hwmon/hwmon0/pwm1             # +-740 RPM
    elif [ $CURRENT_TEMP -lt $THRESHOLD_FAN_SILENT ]
    then
        if [ $DEBUG -gt 0 ]
        then
            echo ""
            echo "shuld switch to silent, temperature under threshold"
        fi
        echo 1 > /sys/class/drm/card0/device/hwmon/hwmon0/pwm1_enable
        echo 0 > /sys/class/drm/card0/device/hwmon/hwmon0/pwm1
    fi
    
    sleep 10
    
done 
