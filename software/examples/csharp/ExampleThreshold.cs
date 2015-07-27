using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback function for humidity outside of 30 to 60 %RH (parameter has unit %RH/10)
	static void HumidityReachedCB(BrickletHumidity sender, int humidity)
	{
		System.Console.WriteLine("Humidity: " + humidity/10.0 + " %RH");
		System.Console.WriteLine("Recommended humiditiy for human comfort is 30 to 60 %RH.");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletHumidity h = new BrickletHumidity(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		h.SetDebouncePeriod(10000);

		// Register threshold reached callback to function HumidityReachedCB
		h.HumidityReached += HumidityReachedCB;

		// Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
		h.SetHumidityCallbackThreshold('o', 30*10, 60*10);

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
