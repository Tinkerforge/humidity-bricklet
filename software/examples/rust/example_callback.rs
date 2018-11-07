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

    let humidity_receiver = h.get_humidity_callback_receiver();

    // Spawn thread to handle received callback messages.
    // This thread ends when the `h` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for humidity in humidity_receiver {
            println!("Humidity: {} %RH", humidity as f32 / 10.0);
        }
    });

    // Set period for humidity receiver to 1s (1000ms).
    // Note: The humidity callback is only called every second
    //       if the humidity has changed since the last call!
    h.set_humidity_callback_period(1000);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
