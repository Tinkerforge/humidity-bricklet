import com.tinkerforge.BrickletHumidity;
import com.tinkerforge.IPConnection;

public class ExampleCallback {
	private static final String host = new String("localhost");
	private static final int port = 4223;
	private static final String UID = new String("ABC"); // Change to your UID
	
	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the commnents below
	public static void main(String args[]) throws Exception {
		// Create connection to brickd
		IPConnection ipcon = new IPConnection(host, port); // Can throw IOException
		BrickletHumidity hum = new BrickletHumidity(UID); // Create device object

		// Add device to IP connection
		ipcon.addDevice(hum); // Can throw IPConnection.TimeoutException
		// Don't use device before it is added to a connection

		// Set Period for humidity callback to 1s (1000ms)
		// Note: The humidity callback is only called every second if the 
		//       humidity has changed since the last call!
		hum.setHumidityCallbackPeriod(1000);

		// Add and implement humidity listener (called if humidity changes)
		hum.addListener(new BrickletHumidity.HumidityListener() {
			public void humidity(int humidity) {
				System.out.println("Relative Humidity: " + humidity/10.0 + " %RH");
			}
		});

		System.out.println("Press ctrl+c to exit");
		ipcon.joinThread();
	}
}
