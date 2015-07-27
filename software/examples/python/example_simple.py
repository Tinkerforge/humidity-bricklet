#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_humidity import Humidity

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    h = Humidity(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get current humidity (unit is %RH/10)
    humidity = h.get_humidity()
    print('Humidity: ' + str(humidity/10.0) + ' %RH')

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
