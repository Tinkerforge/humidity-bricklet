using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Humidity Bricklet

	// Callback function for humidity reached callback
	static void HumidityReachedCB(BrickletHumidity sender, int humidity)
	{
		Console.WriteLine("Humidity: " + humidity/10.0 + " %RH");
		Console.WriteLine("Recommended humidity for human comfort is 30 to 60 %RH.");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletHumidity h = new BrickletHumidity(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		h.SetDebouncePeriod(10000);

		// Register humidity reached callback to function HumidityReachedCB
		h.HumidityReachedCallback += HumidityReachedCB;

		// Configure threshold for humidity "outside of 30 to 60 %RH"
		h.SetHumidityCallbackThreshold('o', 30*10, 60*10);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
