package main

import (
	"fmt"
	"tinkerforge/humidity_bricklet"
	"tinkerforge/ipconnection"
)

const ADDR string = "localhost:4223"
const UID string = "XYZ" // Change XYZ to the UID of your Humidity Bricklet.

func main() {
	ipcon := ipconnection.New()
	defer ipcon.Close()
	h, _ := humidity_bricklet.New(UID, &ipcon) // Create device object.

	ipcon.Connect(ADDR) // Connect to brickd.
	defer ipcon.Disconnect()
	// Don't use device before ipcon is connected.

	h.RegisterHumidityCallback(func(humidity uint16) {
		fmt.Printf("Humidity: %d %RH\n", float64(humidity)/10.0)
	})

	// Set period for humidity receiver to 1s (1000ms).
	// Note: The humidity callback is only called every second
	//       if the humidity has changed since the last call!
	h.SetHumidityCallbackPeriod(1000)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
