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

# Set Period for rh callback to 1s (1000ms)
# Note: The callback is only called every second if the
#       humidity has changed since the last call!
h.set_humidity_callback_period 1000

# Register humidity callback (parameter has unit %RH/10)
h.register_callback BrickletHumidity::CALLBACK_HUMIDITY, do |rh|
  puts "Relative Humidity: #{rh/10.0}  %RH"
end

puts 'Press key to exit'
$stdin.gets
ipcon.destroy
