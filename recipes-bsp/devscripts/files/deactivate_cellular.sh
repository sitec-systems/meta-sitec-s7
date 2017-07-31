#!/bin/sh

IGN=/sys/class/gpio/gpio87/value
PWR=/sys/class/gpio/gpio88/value
EOFF=/sys/class/gpio/gpio89/value

# Starting state
echo 0 > $EOFF
echo 0 > $IGN
echo 0 > $PWR

# Falling Edge EOFF
echo 1 > $EOFF

# Wait 100ms
usleep 100000

# Rising Edge EOFF
echo 0 > $EOFF

# Wait 1 s
sleep 1

# Turn Pwr off
echo 1 > $PWR

# Wait 1 s
sleep 1

