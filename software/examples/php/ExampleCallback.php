<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletHumidity.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletHumidity;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change XYZ to the UID of your Humidity Bricklet

// Callback function for humidity callback (parameter has unit %RH/10)
function cb_humidity($humidity)
{
    echo "Humidity: " . $humidity/10.0 . " %RH\n";
}

$ipcon = new IPConnection(); // Create IP connection
$h = new BrickletHumidity(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Register humidity callback to function cb_humidity
$h->registerCallback(BrickletHumidity::CALLBACK_HUMIDITY, 'cb_humidity');

// Set period for humidity callback to 1s (1000ms)
// Note: The humidity callback is only called every second
//       if the humidity has changed since the last call!
$h->setHumidityCallbackPeriod(1000);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
