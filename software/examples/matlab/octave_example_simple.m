function octave_example_simple()
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "7bA"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    h = java_new("com.tinkerforge.BrickletHumidity", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current humidity (unit is %RH/10)
    rh = h.getHumidity();
    fprintf("Relative Humidity: %g %%RH\n", rh/10.0);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end
