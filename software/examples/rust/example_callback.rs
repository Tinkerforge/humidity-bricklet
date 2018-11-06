use std::{error::Error, io, thread};
use tinkerforge::{humidity_bricklet::*, ipconnection::IpConnection};

const HOST: &str = "127.0.0.1";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Humidity Bricklet

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection
    let humidity_bricklet = HumidityBricklet::new(UID, &ipcon); // Create device object

    ipcon.connect(HOST, PORT).recv()??; // Connect to brickd
                                        // Don't use device before ipcon is connected

    //Create listener for humidity events.
    let humidity_listener = humidity_bricklet.get_humidity_receiver();
    // Spawn thread to handle received events. This thread ends when the humidity_bricklet
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for event in humidity_listener {
            println!("Humidity: {}{}", event as f32 / 10.0, " %RH");
        }
    });

    // Set period for humidity listener to 1s (1000ms)
    // Note: The humidity callback is only called every second
    //       if the humidity has changed since the last call!
    humidity_bricklet.set_humidity_callback_period(1000);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
