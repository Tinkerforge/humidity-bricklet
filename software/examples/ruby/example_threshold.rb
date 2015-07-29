#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_humidity'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change to your UID

ipcon = IPConnection.new # Create IP connection
h = BrickletHumidity.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
h.set_debounce_period 10000

# Register threshold reached callback for humidity outside of 30 to 60 %RH (parameter has unit %RH/10)
h.register_callback(BrickletHumidity::CALLBACK_HUMIDITY_REACHED) do |humidity|
  puts "Humidity: #{humidity/10.0} %RH"
  puts 'Recommended humiditiy for human comfort is 30 to 60 %RH.'
end

# Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
h.set_humidity_callback_threshold 'o', 30*10, 60*10

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
