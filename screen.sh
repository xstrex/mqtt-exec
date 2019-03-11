#!/usr/bin/env bash

############################################################################
# Purpose: 
# 
# Author: Strex
# Contact: strex@morphx.net
# Version: 0.1
# Date: 0/0/00
############################################################################

###############
# Variables
stat_cmd=`cat /sys/class/backlight/rpi_backlight/bl_power`

###############
# Functions
usage () {
	echo "Usage: $0 [ on ] | [ off ] | [ status ] | [ bright ] | [ dim ] | [ brightness 10 - 220 ]"
}

on () {
	echo 0 | sudo tee /sys/class/backlight/rpi_backlight/bl_power >/dev/null 2>&1
}

off () {
	echo 1 | sudo tee /sys/class/backlight/rpi_backlight/bl_power >/dev/null 2>&1
}


bright () {
	echo 200 | sudo tee /sys/class/backlight/rpi_backlight/brightness >/dev/null 2>&1
}

dim () {
	echo 90 | sudo tee /sys/class/backlight/rpi_backlight/brightness >/dev/null 2>&1
}

brightness () {
	if ! [[ "$1" =~ ^[0-9]+$ ]]; then
		if [[ "$1" -ge 10 && "$1" -le 220 ]]; then
			echo "$1" | sudo tee /sys/class/backlight/rpi_backlight/brightness >/dev/null 2>&1
		else
			usage
		fi
	else
		usage
	fi
}

status () {
	if [ "$stat_cmd" == 0 ]; then
		echo "on"
	elif [ "$stat_cmd" == 1 ]; then
		echo "off"
	fi
}

###############
# Terminator
case "$1" in
	on)
		on
	;;
	off)
		off
	;;
	status)
		status
	;;
	bright)
		bright
	;;
	dim)
		dim
	;;
	brightness)
		brightness "$2"
	;;
	*)
		usage
	;;
esac
