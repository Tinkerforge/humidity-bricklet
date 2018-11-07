use std::{error::Error, io, thread};
use tinkerforge::{humidity_bricklet::*, ip_connection::IpConnection};

const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Humidity Bricklet.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let h = HumidityBricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
                                          // Don't use device before ipcon is connected.

    // Get threshold receivers with a debounce time of 10 seconds (10000ms).
    h.set_debounce_period(10000);

    // Create receiver for humidity reached events.
    let humidity_reached_receiver = h.get_humidity_reached_receiver();

    // Spawn thread to handle received events. This thread ends when the `h` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for humidity_reached in humidity_reached_receiver {
            println!("Humidity: {} %RH", humidity_reached as f32 / 10.0);
            println!("Recommended humidity for human comfort is 30 to 60 %RH.");
        }
    });

    // Configure threshold for humidity "outside of 30 to 60 %RH".
    h.set_humidity_callback_threshold('o', 30 * 10, 60 * 10);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
