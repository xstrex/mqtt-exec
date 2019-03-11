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
	echo "Usage: $0 [ on ] | [ off ] | [ status ] | [ bright ] | [ dim ]"
}

on () {
	echo 0 | sudo tee /sys/class/backlight/rpi_backlight/bl_power 2>&1>/dev/null
}

off () {
	echo 1 | sudo tee /sys/class/backlight/rpi_backlight/bl_power 2>&1>/dev/null
}


bright () {
	echo 200 | sudo tee /sys/class/backlight/rpi_backlight/brightness 2>&1>/dev/null
}

dim () {
	echo 90 | sudo tee /sys/class/backlight/rpi_backlight/brightness 2>&1>/dev/null
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
	*)
		usage
	;;
esac