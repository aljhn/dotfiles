#!/bin/sh

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

setxkbmap -layout no
xsetroot -cursor_name left_ptr

exec bspwm
