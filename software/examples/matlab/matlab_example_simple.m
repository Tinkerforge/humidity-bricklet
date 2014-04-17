function matlab_example_simple
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletHumidity;

    HOST = 'localhost';
    PORT = 4223;
    UID = '7bA'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    h = BrickletHumidity(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current humidity (unit is %RH/10)
    rh = h.getHumidity();
    fprintf('Relative Humidity: %g %%RH\n', rh/10.0);

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end
