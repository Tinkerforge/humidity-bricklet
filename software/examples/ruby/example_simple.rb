#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_humidity'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = '7bA' # Change to your UID

ipcon = IPConnection.new HOST, PORT # Create IP connection to brickd
h = BrickletHumidity.new UID # Create device object
ipcon.add_device h # Add device to IP connection
# Don't use device before it is added to a connection

# Get current humidity (unit is %RH/10)
rh = h.get_humidity / 10.0
puts "Relative Humidity: #{rh}  %RH"

puts 'Press key to exit'
$stdin.gets
ipcon.destroy
