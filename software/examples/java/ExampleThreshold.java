import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletHumidity;

public class ExampleThreshold {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;

	// Change XYZ to the UID of your Humidity Bricklet
	private static final String UID = "XYZ";

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions
	//       you might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletHumidity h = new BrickletHumidity(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		h.setDebouncePeriod(10000);

		// Add humidity reached listener
		h.addHumidityReachedListener(new BrickletHumidity.HumidityReachedListener() {
			public void humidityReached(int humidity) {
				System.out.println("Humidity: " + humidity/10.0 + " %RH");
				System.out.println("Recommended humidity for human comfort is 30 to 60 %RH.");
			}
		});

		// Configure threshold for humidity "outside of 30 to 60 %RH"
		h.setHumidityCallbackThreshold('o', 30*10, 60*10);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
