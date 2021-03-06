#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Humidity Bricklet

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
tinkerforge call humidity-bricklet $uid set-debounce-period 10000

# Handle incoming humidity reached callbacks
tinkerforge dispatch humidity-bricklet $uid humidity-reached\
 --execute "echo Humidity: {humidity}/10 %RH. Recommended humidity for human comfort is 30 to 60 %RH." &

# Configure threshold for humidity "outside of 30 to 60 %RH"
tinkerforge call humidity-bricklet $uid set-humidity-callback-threshold threshold-option-outside 300 600

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
