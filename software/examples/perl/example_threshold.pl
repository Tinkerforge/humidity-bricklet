#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletHumidity;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '7bA'; # Change to your UID

my $ipcon = IPConnection->new(); # Create IP connection
my $h = BrickletHumidity->new(&UID, $ipcon); # Create device object

# Callback function for humidity callback (parameter has unit %RH/10)
sub cb_reached
{
    my ($humidity) = @_;

    if($humidity < 30*10)
    {
        print "\nHumidity too low: ".$humidity/10.0." RH%\n";
    }   
    if($humidity > 60*10)
    {
        print "\nHumidity too high: ".$humidity/10.0." RH%\n";
    } 

    print "\nRecommended humiditiy for human comfort is 30 to 60 %RH.\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$h->set_debounce_period(100);

# Register threshold reached callback to function cb_reached
$h->register_callback($h->CALLBACK_HUMIDITY_REACHED, 'cb_reached');

# Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
$h->set_humidity_callback_threshold('o', 30*10, 60*10);

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

