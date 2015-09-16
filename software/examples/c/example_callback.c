#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_humidity.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

// Callback function for humidity callback (parameter has unit %RH/10)
void cb_humidity(uint16_t humidity, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Humidity: %f %%RH\n", humidity/10.0);
}

int main(void) {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	Humidity h;
	humidity_create(&h, UID, &ipcon);

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		return 1;
	}
	// Don't use device before ipcon is connected

	// Register humidity callback to function cb_humidity
	humidity_register_callback(&h,
	                           HUMIDITY_CALLBACK_HUMIDITY,
	                           (void *)cb_humidity,
	                           NULL);

	// Set period for humidity callback to 1s (1000ms)
	// Note: The humidity callback is only called every second
	//       if the humidity has changed since the last call!
	humidity_set_humidity_callback_period(&h, 1000);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
	return 0;
}
