<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletHumidity.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletHumidity;

$host = 'localhost';
$port = 4223;
$uid = '7bA'; // Change to your UID

$ipcon = new IPConnection($host, $port); // Create IP connection to brickd
$h = new BrickletHumidity($uid); // Create device object

$ipcon->addDevice($h); // Add device to IP connection
// Don't use device before it is added to a connection

// Get current humidity (unit is %RH/10)
$rh = $h->getHumidity() / 10.0;

echo "Relative Humidity: $rh %RH\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->destroy();

?>
