function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    h = java_new("com.tinkerforge.BrickletHumidity", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register humidity callback to function cb_humidity
    h.addHumidityCallback(@cb_humidity);

    % Set period for humidity callback to 1s (1000ms)
    % Note: The humidity callback is only called every second
    %       if the humidity has changed since the last call!
    h.setHumidityCallbackPeriod(1000);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for humidity callback (parameter has unit %RH/10)
function cb_humidity(e)
    fprintf("Humidity: %g %%RH\n", e.humidity/10.0);
end
