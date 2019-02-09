#!/bin/bash

cmd=$(echo -e "                     lock\n                     logout\n                     suspend\n                     reboot\n                     shutdown" | rofi -dmenu -p " " -theme config-dmenu)
case $cmd in
    "                     lock")
	i3lock-fancy -p -f 'Sauce-Code-Pro-Bold-Nerd-Font-Complete-Mono' -t 'You will never find my password' -- maim	
	;;
    "                     logout")
        i3-msg exit
        ;;
    "                     suspend")
	i3lock-fancy -p -f 'Sauce-Code-Pro-Bold-Nerd-Font-Complete-Mono' -t 'You will never find my password' -- maim; systemctl suspend
	;;
#    "                     hibernate")
#	i3lock-fancy -p -f 'Sauce-Code-Pro-Bold-Nerd-Font-Complete-Mono' -t 'You will never find my password' -- maim; systemctl hibernate 
#	;;
    "                     reboot")
        reboot
        ;;
    "                     shutdown")
        shutdown 0
        ;;
esac
