using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	// Callback for humidity outside of 30 to 60 %RH
	static void ReachedCB(ushort humidity)
	{
		if(humidity < 30*10)
		{
			System.Console.WriteLine("Humidity too low: " + humidity/10.0 + " %RH");
		}
		if(humidity > 60*10)
		{
			System.Console.WriteLine("Humidity too high: " + humidity/10.0 + " %RH");
		}

		System.Console.WriteLine("Recommended humiditiy for human comfort is 30 to 60 %RH.");
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(HOST, PORT); // Create connection to brickd
		BrickletHumidity hum = new BrickletHumidity(UID); // Create device object
		ipcon.AddDevice(hum); // Add device to IP connection
		// Don't use device before it is added to a connection

		// Get threshold callbacks with a debounce time of 1 seconds (1000ms)
		hum.SetDebouncePeriod(1000);

		// Register threshold reached callback to function ReachedCB
		hum.RegisterCallback(new BrickletHumidity.HumidityReached(ReachedCB));

		// Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
		hum.SetHumidityCallbackThreshold('o', 30*10, 60*10);

		System.Console.WriteLine("Press ctrl+c to exit");
		ipcon.JoinThread();
	}
}
