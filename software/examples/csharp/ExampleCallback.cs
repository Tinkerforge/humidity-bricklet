using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	// Callback function for humidity callback (parameter has unit %RH/10)
	static void HumidityCB(object sender, int humidity)
	{
		System.Console.WriteLine("Relative Humidity: " + humidity/10.0 + " %RH");
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletHumidity hum = new BrickletHumidity(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set Period for humidity callback to 1s (1000ms)
		// Note: The humidity callback is only called every second if the 
		//       humidity has changed since the last call!
		hum.SetHumidityCallbackPeriod(1000);

		// Register humidity callback to function HumidityCB
		hum.Humidity += HumidityCB;

		System.Console.WriteLine("Press key to exit");
		System.Console.ReadKey();
	}
}
