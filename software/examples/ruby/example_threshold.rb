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

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
h.set_debounce_period 10000

# Register callback for humidity outside of 30 to 60 %RH
h.register_callback BrickletHumidity::CALLBACK_HUMIDITY_REACHED, do |humidity|
  if humidity < 30*10
    puts "Humidity too low: #{humidity/10.0} %RH"
  end
  if humidity > 60*10
    puts "Humidity too high: #{humidity/10.0} %RH"
  end

  puts 'Recommended humiditiy for human comfort is 30 to 60 %RH.'
end

# Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
h.set_humidity_callback_threshold 'o', 30*10, 60*10

puts 'Press key to exit'
$stdin.gets
ipcon.destroy
