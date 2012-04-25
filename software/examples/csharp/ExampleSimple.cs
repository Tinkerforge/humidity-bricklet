using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(HOST, PORT); // Create connection to brickd
		BrickletHumidity hum = new BrickletHumidity(UID); // Create device object
		ipcon.AddDevice(hum); // Add device to IP connection
		// Don't use device before it is added to a connection

		// Get current humidity (unit is %RH/10)
		ushort humidity;
		hum.GetHumidity(out humidity);

		System.Console.WriteLine("Humidity: " + humidity/10.0 + " %RH");

		System.Console.WriteLine("Press ctrl+c to exit");
		ipcon.JoinThread();
	}
}
