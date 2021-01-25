#!/bin/bash

if [ $(cat /sys/class/rfkill/rfkill1/soft) -eq 1 ]; then rfkill unblock 1; else rfkill block 1; fi
