#!/usr/bin/perl

use strict;
use Tinkerforge::IPConnection;
use Tinkerforge::BrickletHumidity;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Humidity Bricklet

# Callback subroutine for humidity callback
sub cb_humidity
{
    my ($humidity) = @_;

    print "Humidity: " . $humidity/10.0 . " %RH\n";
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $h = Tinkerforge::BrickletHumidity->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Register humidity callback to subroutine cb_humidity
$h->register_callback($h->CALLBACK_HUMIDITY, 'cb_humidity');

# Set period for humidity callback to 1s (1000ms)
# Note: The humidity callback is only called every second
#       if the humidity has changed since the last call!
$h->set_humidity_callback_period(1000);

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
