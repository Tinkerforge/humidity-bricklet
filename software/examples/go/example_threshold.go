package main

import (
	"fmt"
	"github.com/Tinkerforge/go-api-bindings/humidity_bricklet"
	"github.com/Tinkerforge/go-api-bindings/ipconnection"
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

	// Get threshold receivers with a debounce time of 10 seconds (10000ms).
	h.SetDebouncePeriod(10000)

	h.RegisterHumidityReachedCallback(func(humidity uint16) {
		fmt.Printf("Humidity: %f %%RH\n", float64(humidity)/10.0)
		fmt.Println("Recommended humidity for human comfort is 30 to 60 %RH.")
	})

	// Configure threshold for humidity "outside of 30 to 60 %RH".
	h.SetHumidityCallbackThreshold('o', 30*10, 60*10)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()
}
