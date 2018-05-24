#!/usr/bin/perl

use strict;
use Tinkerforge::IPConnection;
use Tinkerforge::BrickletHumidity;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Humidity Bricklet

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $h = Tinkerforge::BrickletHumidity->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current humidity
my $humidity = $h->get_humidity();
print "Humidity: " . $humidity/10.0 . " %RH\n";

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
