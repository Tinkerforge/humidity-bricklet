function octave_example_threshold()
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "7bA"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    h = java_new("com.tinkerforge.BrickletHumidity", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set threshold callbacks with a debounce time of 10 seconds (10000ms)
    h.setDebouncePeriod(10000);

    % Register threshold reached callback to function cb_reached
    h.addHumidityReachedCallback(@cb_reached);

    % Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
    h.setHumidityCallbackThreshold(h.THRESHOLD_OPTION_OUTSIDE, 30*10, 60*10);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback for humidity outside of 30 to 60 %RH
function cb_reached(e)
    if e.humidity < 30*10
        fprintf("Humidity too low: %g %%RH\n", e.humidity/10.0);
    elseif e.humidity > 60*10
        fprintf("Humidity too high: %g %%RH\n", e.humidity/10.0);
    end
    fprintf("Recommended humiditiy for human comfort is 30 to 60 %%RH.\n");
end
