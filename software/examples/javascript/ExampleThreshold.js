var IPConnection = require('Tinkerforge/IPConnection');
var BrickletHumidity = require('Tinkerforge/BrickletHumidity');

var HOST = 'localhost';
var PORT = 4223;
var UID = '7bA'; //Change to your UID

var ipcon = new IPConnection(); //Create IP connection
var h = new BrickletHumidity(UID, ipcon); //Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        if(error === IPConnection.ERROR_ALREADY_CONNECTED) {
            console.log('Error: Already connected');        
        }
    }
);//Connect to brickd

//Don't use device before ipcon is connected
ipcon.on(IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Set threshold callbacks with a debounce time of 10 seconds (10000ms)
        h.setDebouncePeriod(10000); 
        // Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
        h.setHumidityCallbackThreshold('o', 30*10, 60*10);    
    }
);

// Register threshold reached callback
h.on(BrickletHumidity.CALLBACK_HUMIDITY_REACHED,
    // Callback for humidity outside of 30 to 60 %RH
    function(humidity) {
        if(humidity < 30*10) {
            console.log('Humidity too low: '+humidity/10+' %RH');
        }
        if(humidity > 60*10) {
            console.log('Humidity too high: '+humidity/10+' %RH');
        }
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data', function(data) {
	    ipcon.disconnect(
            function(error) {
                if(error === IPConnection.ERROR_NOT_CONNECTED) {
                    console.log('Error: Not connected');        
                }
            }
        );
process.exit(0);
});

