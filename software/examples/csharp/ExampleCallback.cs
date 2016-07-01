using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Humidity Bricklet

	// Callback function for humidity callback (parameter has unit %RH/10)
	static void HumidityCB(BrickletHumidity sender, int humidity)
	{
		Console.WriteLine("Humidity: " + humidity/10.0 + " %RH");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletHumidity h = new BrickletHumidity(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Register humidity callback to function HumidityCB
		h.Humidity += HumidityCB;

		// Set period for humidity callback to 1s (1000ms)
		// Note: The humidity callback is only called every second
		//       if the humidity has changed since the last call!
		h.SetHumidityCallbackPeriod(1000);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
