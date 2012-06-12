import com.tinkerforge.BrickletHumidity;
import com.tinkerforge.IPConnection;

public class ExampleThreshold {
	private static final String host = "localhost";
	private static final int port = 4223;
	private static final String UID = "ABC"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the commnents below
	public static void main(String args[]) throws Exception {
		// Create connection to brickd
		IPConnection ipcon = new IPConnection(host, port); // Can throw IOException
		BrickletHumidity hum = new BrickletHumidity(UID); // Create device object

		// Add device to IP connection
		ipcon.addDevice(hum); // Can throw IPConnection.TimeoutException
		// Don't use device before it is added to a connection

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		hum.setDebouncePeriod(10000);

		// Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
		hum.setHumidityCallbackThreshold('o', (short)(30*10), (short)(60*10));

		// Add and implement humidity reached listener 
		// (called if humidity is outside of 30 to 60 %RH)
		hum.addListener(new BrickletHumidity.HumidityReachedListener() {
			public void humidityReached(int humidity) {
				if(humidity < 30*10) {
					System.out.println("Humidity too low: " + humidity/10.0 + " %RH");
				} 
				if(humidity > 60*10) {
					System.out.println("Humidity too high: " + humidity/10.0 + " %RH");
				}

				System.out.println("Recommended humiditiy for human comfort is 30 to 60 %RH.");
			}
		});

		System.console().readLine("Press key to exit\n");
		ipcon.destroy();
	}
}
