#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change to your UID

# Get current humidity (unit is %RH/10)
tinkerforge call humidity-bricklet $uid get-humidity
