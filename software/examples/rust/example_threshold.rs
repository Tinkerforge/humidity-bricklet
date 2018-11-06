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

    // Get threshold listeners with a debounce time of 10 seconds (10000ms)
    humidity_bricklet.set_debounce_period(10000);

    //Create listener for humidity reached events.
    let humidity_reached_listener = humidity_bricklet.get_humidity_reached_receiver();
    // Spawn thread to handle received events. This thread ends when the humidity_bricklet
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for event in humidity_reached_listener {
            println!("Humidity: {}{}", event as f32 / 10.0, " %RH");
            println!("Recommended humidity for human comfort is 30 to 60 %RH.");
        }
    });

    // Configure threshold for humidity "outside of 30 to 60 %RH"
    humidity_bricklet.set_humidity_callback_threshold('o', 30 * 10, 60 * 10);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
