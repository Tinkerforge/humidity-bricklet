var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'XYZ'; // Change XYZ to the UID of your Humidity Bricklet

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var h = new Tinkerforge.BrickletHumidity(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function (error) {
        console.log('Error: ' + error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function (connectReason) {
        // Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        h.setDebouncePeriod(10000);

        // Configure threshold for humidity "outside of 30 to 60 %RH" (unit is %RH/10)
        h.setHumidityCallbackThreshold('o', 30*10, 60*10);
    }
);

// Register humidity reached callback
h.on(Tinkerforge.BrickletHumidity.CALLBACK_HUMIDITY_REACHED,
    // Callback function for humidity reached callback (parameter has unit %RH/10)
    function (humidity) {
        console.log('Humidity: ' + humidity/10.0 + ' %RH');
        console.log('Recommended humiditiy for human comfort is 30 to 60 %RH.');
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
