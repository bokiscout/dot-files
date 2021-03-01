#!/bin/sh
# Xsetup - run as root before the login dialog appears

if [ -e /sbin/prime-offload ]; then
    echo running NVIDIA Prime setup /sbin/prime-offload
    /sbin/prime-offload
fi

# Monitor / tv setup
#
# The monitor is primary display (the cursor is at)
# The tv is on the right
xrandr --output DVI-D-0 --primary;
xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60;
xrandr --output HDMI-A-0 --right-of DVI-D-0
