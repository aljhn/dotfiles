#!/bin/sh


#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto

exec setxkbmap -option 'numpad:microsoft' &

exec i3
