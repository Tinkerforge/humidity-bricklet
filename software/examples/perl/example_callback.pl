#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletHumidity;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '7bA'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $h = Tinkerforge::BrickletHumidity->new(&UID, $ipcon); # Create device object

# Callback function for humidity callback (parameter has unit %RH/10)
sub cb_humidity
{
    my ($rh) = @_;
    print "\nRelative Humidity: ".$rh/10.0." RH%\n";
}
$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set Period for rh callback to 1s (1000ms)
# Note: The callback is only called every second if the 
#       humidity has changed since the last call!
$h->set_humidity_callback_period(1000);

# Register humidity callback to function cb_humidity
$h->register_callback($h->CALLBACK_HUMIDITY, 'cb_humidity');

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

