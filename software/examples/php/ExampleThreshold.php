<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletHumidity.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletHumidity;

const HOST = 'localhost';
const PORT = 4223;
const UID = '7bA'; // Change to your UID

// Callback for humidity outside of 30 to 60 %RH
function cb_reached($humidity)
{
    if ($humidity < 30*10) {
        echo "Humidity too low: " . $humidity / 10.0 . " %RH\n";
    }

    if ($humidity > 60*10) {
        echo "Humidity too high: " . $humidity / 10.0 . " %RH\n";
    }

    echo "Recommended humiditiy for human comfort is 30 to 60 %RH.\n";
}

$ipcon = new IPConnection(); // Create IP connection
$h = new BrickletHumidity(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$h->setDebouncePeriod(10000);

// Register threshold reached callback to function cb_reached
$h->registerCallback(BrickletHumidity::CALLBACK_HUMIDITY_REACHED, 'cb_reached');

// Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
$h->setHumidityCallbackThreshold('o', 30*10, 60*10);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
