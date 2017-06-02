function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Humidity Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    h = javaObject("com.tinkerforge.BrickletHumidity", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current humidity (unit is %RH/10)
    humidity = h.getHumidity();
    fprintf("Humidity: %g %%RH\n", humidity/10.0);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end
