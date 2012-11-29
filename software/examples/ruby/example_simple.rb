#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_humidity'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = '7bA' # Change to your UID

ipcon = IPConnection.new # Create IP connection
h = BrickletHumidity.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current humidity (unit is %RH/10)
rh = h.get_humidity / 10.0
puts "Relative Humidity: #{rh}  %RH"

puts 'Press key to exit'
$stdin.gets
