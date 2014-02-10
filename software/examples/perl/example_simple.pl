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

# Get current humidity (unit is %RH/10)
my $rh = $h->get_humidity()/10.0;

print "\nRelative Humidity: ".$rh." RH%\n";

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

