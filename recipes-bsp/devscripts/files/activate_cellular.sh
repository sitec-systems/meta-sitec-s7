#!/bin/sh

IGN=/sys/class/gpio/gpio87/value
PWR=/sys/class/gpio/gpio88/value
EOFF=/sys/class/gpio/gpio89/value

# Starting State
echo 0 > $EOFF
echo 0 > $IGN
echo 1 > $PWR

# Turning on PWR
echo 0 > $PWR

# Wait 50 ms
usleep 50000

# Falling Edge IGN
echo 1 > $IGN

# Wait 200 ms
usleep 200000

# Rising Edge IGN
echo 0 > $IGN

# Wait for 1 s
sleep 1
