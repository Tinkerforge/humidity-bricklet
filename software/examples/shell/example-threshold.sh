#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=7bA

# get threshold callbacks with a debounce time of 10 seconds (10000ms)
tinkerforge call humidity-bricklet $uid set-debounce-period 10000

# configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
tinkerforge call humidity-bricklet $uid set-humidity-callback-threshold outside 300 600

# handle incoming humidity-reached callbacks (unit is %RH/10)
tinkerforge dispatch humidity-bricklet $uid humidity-reached\
 --execute "if   [ {humidity} -lt 300 ]; then echo 'Humidity too low: {humidity} %RH/10';
            elif [ {humidity} -gt 600 ]; then echo 'Humidity too high: {humidity} %RH/10'; fi;
            echo Recommended humiditiy for human comfort is 300 to 600 %RH/10"
