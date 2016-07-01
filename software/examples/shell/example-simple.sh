#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Humidity Bricklet

# Get current humidity (unit is %RH/10)
tinkerforge call humidity-bricklet $uid get-humidity
