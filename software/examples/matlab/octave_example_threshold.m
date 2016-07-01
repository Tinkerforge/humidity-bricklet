function octave_example_threshold()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Humidity Bricklet

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    h = java_new("com.tinkerforge.BrickletHumidity", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    h.setDebouncePeriod(10000);

    % Register humidity reached callback to function cb_humidity_reached
    h.addHumidityReachedCallback(@cb_humidity_reached);

    % Configure threshold for humidity "outside of 30 to 60 %RH" (unit is %RH/10)
    h.setHumidityCallbackThreshold("o", 30*10, 60*10);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for humidity reached callback (parameter has unit %RH/10)
function cb_humidity_reached(e)
    fprintf("Humidity: %g %%RH\n", e.humidity/10.0);
    fprintf("Recommended humiditiy for human comfort is 30 to 60 %%RH.\n");
end
