<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletHumidity.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletHumidity;

$host = 'localhost';
$port = 4223;
$uid = '7bA'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$h = new BrickletHumidity($uid, $ipcon); // Create device object

$ipcon->connect($host, $port); // Connect to brickd
// Don't use device before ipcon is connected

// Get current humidity (unit is %RH/10)
$rh = $h->getHumidity() / 10.0;

echo "Relative Humidity: $rh %RH\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));

?>
