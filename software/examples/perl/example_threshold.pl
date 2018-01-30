#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletHumidity;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Humidity Bricklet

# Callback subroutine for humidity reached callback
sub cb_humidity_reached
{
    my ($humidity) = @_;

    print "Humidity: " . $humidity/10.0 . " %RH\n";
    print "Recommended humiditiy for human comfort is 30 to 60 %RH.\n";
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $h = Tinkerforge::BrickletHumidity->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$h->set_debounce_period(10000);

# Register humidity reached callback to subroutine cb_humidity_reached
$h->register_callback($h->CALLBACK_HUMIDITY_REACHED, 'cb_humidity_reached');

# Configure threshold for humidity "outside of 30 to 60 %RH"
$h->set_humidity_callback_threshold('o', 30*10, 60*10);

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
