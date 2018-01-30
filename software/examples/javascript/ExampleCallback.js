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
        // Set period for humidity callback to 1s (1000ms)
        // Note: The humidity callback is only called every second
        //       if the humidity has changed since the last call!
        h.setHumidityCallbackPeriod(1000);
    }
);

// Register humidity callback
h.on(Tinkerforge.BrickletHumidity.CALLBACK_HUMIDITY,
    // Callback function for humidity callback
    function (humidity) {
        console.log('Humidity: ' + humidity/10.0 + ' %RH');
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
