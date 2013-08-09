#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=7bA

# set period for humidity callback to 1s (1000ms)
# note: the humidity callback is only called every second if the
#       humidity has changed since the last call!
tinkerforge call humidity-bricklet $uid set-humidity-callback-period 1000

# handle incoming humidity callbacks (unit is %RH/10)
tinkerforge dispatch humidity-bricklet $uid humidity
