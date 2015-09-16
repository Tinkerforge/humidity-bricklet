<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletHumidity.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletHumidity;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

// Callback function for humidity reached callback (parameter has unit %RH/10)
function cb_humidityReached($humidity)
{
    echo "Humidity: " . $humidity/10.0 . " %RH\n";
    echo "Recommended humiditiy for human comfort is 30 to 60 %RH.\n";
}

$ipcon = new IPConnection(); // Create IP connection
$h = new BrickletHumidity(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$h->setDebouncePeriod(10000);

// Register humidity reached callback to function cb_humidityReached
$h->registerCallback(BrickletHumidity::CALLBACK_HUMIDITY_REACHED, 'cb_humidityReached');

// Configure threshold for humidity "outside of 30 to 60 %RH" (unit is %RH/10)
$h->setHumidityCallbackThreshold('o', 30*10, 60*10);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
