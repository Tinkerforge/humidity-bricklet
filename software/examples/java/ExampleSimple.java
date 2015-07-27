import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletHumidity;

public class ExampleSimple {
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

		// Get current humidity (unit is %RH/10)
		int humidity = h.getHumidity(); // Can throw com.tinkerforge.TimeoutException
		System.out.println("Humidity: " + humidity/10.0 + " %RH");

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
