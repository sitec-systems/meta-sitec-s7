#!/bin/sh

IGN=/sys/class/gpio/gpio87/value
PWR=/sys/class/gpio/gpio88/value
EOFF=/sys/class/gpio/gpio89/value

# Starting state
echo 0 > $EOFF
echo 1 > $IGN
echo 1 > $PWR

echo 0 > $IGN
usleep 200000

# Turn Pwr off
echo 0 > $PWR

