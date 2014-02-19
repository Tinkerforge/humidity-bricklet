var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = '7bA';// Change to your UID

var ipcon = new Tinkerforge.IPConnection();// Create IP connection
var h = new Tinkerforge.BrickletHumidity(UID, ipcon);// Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);        
    }
);// Connect to brickd

// Don't use device before ipcon is connected
ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Get current humidity (unit is %RH/10)
        h.getHumidity(
            function(humidity) {
                console.log('Relative Humidity: '+humidity/10+' %RH');
            },
            function(error) {
                console.log('Error: '+error);
            }
        );
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);

