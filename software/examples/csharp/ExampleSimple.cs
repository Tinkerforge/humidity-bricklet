using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletHumidity hum = new BrickletHumidity(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current humidity (unit is %RH/10)
		int humidity = hum.GetHumidity();

		System.Console.WriteLine("Humidity: " + humidity/10.0 + " %RH");

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
