import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletHumidity;

public class ExampleCallback {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "XYZ"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions
	//       you might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletHumidity h = new BrickletHumidity(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Add humidity listener (parameter has unit %RH/10)
		h.addHumidityListener(new BrickletHumidity.HumidityListener() {
			public void humidity(int humidity) {
				System.out.println("Humidity: " + humidity/10.0 + " %RH");
			}
		});

		// Set period for humidity callback to 1s (1000ms)
		// Note: The humidity callback is only called every second
		//       if the humidity has changed since the last call!
		h.setHumidityCallbackPeriod(1000);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
