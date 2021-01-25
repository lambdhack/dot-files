#!/bin/bash

if [ $(cat /sys/class/rfkill/rfkill0/soft) -eq 1 ]; then rfkill unblock 0; else rfkill block 0; fi
