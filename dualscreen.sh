#!/bin/sh

screen1="LVDS1"
screen2="VGA1"

usage() {
    echo "$(basename $0) [off]"
    echo
    echo "By default it will start $screen2 at the right of $screen1"
}

if [ X"$1" = X"" ]; then
    set -x
    xrandr --output $screen2 --auto
    xrandr --output $screen2 --right-of $screen1
elif [ X"$1" = X"off" ]; then
    set -x
    xrandr --output $screen2 --off
else
    usage
fi
