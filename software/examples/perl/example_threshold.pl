#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletHumidity;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $h = Tinkerforge::BrickletHumidity->new(&UID, $ipcon); # Create device object

# Callback subroutine for humidity outside of 30 to 60 %RH (parameter has unit %RH/10)
sub cb_humidity_reached
{
    my ($humidity) = @_;

    print "Humidity: " . $humidity/10.0 . " %RH\n";
    print "Recommended humiditiy for human comfort is 30 to 60 %RH.";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$h->set_debounce_period(10000);

# Register threshold reached callback to subroutine cb_humidity_reached
$h->register_callback($h->CALLBACK_HUMIDITY_REACHED, 'cb_humidity_reached');

# Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
$h->set_humidity_callback_threshold('o', 30*10, 60*10);

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
