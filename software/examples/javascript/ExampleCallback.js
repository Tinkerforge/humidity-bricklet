var IPConnection = require('Tinkerforge/IPConnection');
var BrickletHumidity = require('Tinkerforge/BrickletHumidity');

var HOST = 'localhost';
var PORT = 4223;
var UID = '7bA'; // Change to your UID

var ipcon = new IPConnection(); // Create IP connection
var h = new BrickletHumidity(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        if(error === IPConnection.ERROR_ALREADY_CONNECTED) {
            console.log('Error: Already connected');        
        }
    }
);// Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Set Period for rh callback to 1s (1000ms)
        // Note: The callback is only called every second if the 
        // humidity has changed since the last call!
        h.setHumidityCallbackPeriod(1000);
    }
);

// Register position callback
h.on(BrickletHumidity.CALLBACK_HUMIDITY,
    function(humidity) {
        console.log('Relative Humidity: '+humidity/10+' %RH');
    }
); 

console.log("Press any key to exit ...");
process.stdin.on('data', function(data) {
	    ipcon.disconnect(
            function(error) {
                if(error === IPConnection.ERROR_NOT_CONNECTED) {
                    console.log('Error: Already disconnected');        
                }
            }
        );
process.exit(0);
});

