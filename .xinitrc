#!/bin/sh


xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

#exec setxkbmap -option 'numpad:microsoft' &

# Optimus-manager: run prime-offload as a non-root after starting xorg
exec /usr/bin/prime-offload &

exec i3

