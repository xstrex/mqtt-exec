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
stat=$(cat /sys/class/backlight/rpi_backlight/bl_power)
statb=$(cat /sys/class/backlight/rpi_backlight/brightness)
min_br="15"
max_br="220"
br="100"
dm="30"

###############
# Functions
usage () {
	echo "Usage: $0 [ on ] | [ off ] | [ brightness [ # ] | [ $min_br - $max_br ] ] | [ status ]"
}

on () {
	echo 0 | sudo tee /sys/class/backlight/rpi_backlight/bl_power >/dev/null 2>&1
}

off () {
	echo 1 | sudo tee /sys/class/backlight/rpi_backlight/bl_power >/dev/null 2>&1
}

bright () {
	echo "$br" | sudo tee /sys/class/backlight/rpi_backlight/brightness >/dev/null 2>&1
}

dim () {
	echo "$dm" | sudo tee /sys/class/backlight/rpi_backlight/brightness >/dev/null 2>&1
}

brightness () {
	if [[ -n "$1" ]] && [[ "$1" -eq "$1" ]] 2>/dev/null; then
		if [[ "$1" -ge "$min_br" && "$1" -le "$max_br" ]]; then
			echo "$1" | sudo tee /sys/class/backlight/rpi_backlight/brightness >/dev/null 2>&1
		else
			echo "Sorry, outside acceptable range, or not a number"
			usage
		fi
	else
		echo "$statb"
	fi
}

status () {
	if [[ "$stat" == 0 ]]; then
		echo "on"
	elif [[ "$stat" == 1 ]]; then
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
