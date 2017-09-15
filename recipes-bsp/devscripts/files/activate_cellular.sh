#!/bin/sh

IGN=/sys/class/gpio/gpio87/value
PWR=/sys/class/gpio/gpio88/value
EOFF=/sys/class/gpio/gpio89/value

# Starting State
echo 0 > $EOFF
echo 0 > $IGN
echo 0 > $PWR

# Turning on PWR
echo 1 > $PWR

# Wait 50 ms
usleep 50000

echo 1 > $IGN
