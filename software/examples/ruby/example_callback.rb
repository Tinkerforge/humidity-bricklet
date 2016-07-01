#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_humidity'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change XYZ to the UID of your Humidity Bricklet

ipcon = IPConnection.new # Create IP connection
h = BrickletHumidity.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Register humidity callback (parameter has unit %RH/10)
h.register_callback(BrickletHumidity::CALLBACK_HUMIDITY) do |humidity|
  puts "Humidity: #{humidity/10.0} %RH"
end

# Set period for humidity callback to 1s (1000ms)
# Note: The humidity callback is only called every second
#       if the humidity has changed since the last call!
h.set_humidity_callback_period 1000

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
