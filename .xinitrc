#!/bin/sh


xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# Fix Num Lock
exec setxkbmap -option 'numpad:microsoft' &

# Cursor fix
xsetroot -cursor_name left_ptr

# Optimus-manager: run prime-offload as a non-root after starting xorg
exec /usr/bin/prime-offload &

#exec i3
exec bspwm
