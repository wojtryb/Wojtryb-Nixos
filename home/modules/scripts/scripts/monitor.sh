#!/usr/bin/env bash

xrandr --newmode "2560x1440_57.75"  299.73  2560 2744 3024 3488  1440 1441 1444 1488  -HSync +Vsync
xrandr --addmode HDMI-1 "2560x1440_57.75"
xrandr --output HDMI-1 --mode "2560x1440_57.75"

