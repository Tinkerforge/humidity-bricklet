function matlab_example_callback()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletHumidity;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    h = handle(BrickletHumidity(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register humidity callback to function cb_humidity
    set(h, 'HumidityCallback', @(h, e) cb_humidity(e));

    % Set period for humidity callback to 1s (1000ms)
    % Note: The humidity callback is only called every second
    %       if the humidity has changed since the last call!
    h.setHumidityCallbackPeriod(1000);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for humidity callback (parameter has unit %RH/10)
function cb_humidity(e)
    fprintf('Humidity: %g %%RH\n', e.humidity/10.0);
end
