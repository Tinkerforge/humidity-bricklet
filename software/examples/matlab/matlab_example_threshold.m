function matlab_example_threshold
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletHumidity;

    HOST = 'localhost';
    PORT = 4223;
    UID = '7bA'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    h = BrickletHumidity(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set threshold callbacks with a debounce time of 10 seconds (10000ms)
    h.setDebouncePeriod(10000);

    % Register threshold reached callback to function cb_reached
    set(h, 'HumidityReachedCallback', @(h, e)cb_reached(e.humidity/10));

    % Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
    h.setHumidityCallbackThreshold('o', 30*10, 60*10);

    input('\nPress any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback for humidity outside of 30 to 60 %RH
function cb_reached(humidity_value)
    if humidity_value < 30
        fprintf('Humidity too low: %g %%RH\n', humidity_value);
    elseif humidity_value > 60
        fprintf('Humidity too high: %g %%RH\n', humidity_value);
    end
    fprintf('Recommended humiditiy for human comfort is 30 to 60 %%RH.\n')
end
