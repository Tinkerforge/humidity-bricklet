#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Humidity Bricklet

# Handle incoming humidity callbacks (parameter has unit %RH/10)
tinkerforge dispatch humidity-bricklet $uid humidity &

# Set period for humidity callback to 1s (1000ms)
# Note: The humidity callback is only called every second
#       if the humidity has changed since the last call!
tinkerforge call humidity-bricklet $uid set-humidity-callback-period 1000

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
