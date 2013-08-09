#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=7bA

# get current humidity (unit is %RH/10)
tinkerforge call humidity-bricklet $uid get-humidity
