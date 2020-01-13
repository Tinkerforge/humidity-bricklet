#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change XYZ to the UID of your Humidity Bricklet

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_humidity import BrickletHumidity

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    h = BrickletHumidity(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get current humidity
    humidity = h.get_humidity()
    print("Humidity: " + str(humidity/10.0) + " %RH")

    input("Press key to exit\n") # Use raw_input() in Python 2
    ipcon.disconnect()
