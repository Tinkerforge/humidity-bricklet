import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletHumidity;

public class ExampleThreshold {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "XYZ"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletHumidity h = new BrickletHumidity(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		h.setDebouncePeriod(10000);

		// Configure threshold for "outside of 30 to 60 %RH" (unit is %RH/10)
		h.setHumidityCallbackThreshold('o', (short)(30*10), (short)(60*10));

		// Add threshold reached listener for humidity outside of 30 to 60 %RH (parameter has unit %RH/10)
		h.addHumidityReachedListener(new BrickletHumidity.HumidityReachedListener() {
			public void humidityReached(int humidity) {
				System.out.println("Humidity: " + humidity/10.0 + " %RH");
				System.out.println("Recommended humiditiy for human comfort is 30 to 60 %RH.");
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
