/*************************************************************
 * This file was automatically generated on 23.08.2011.      *
 *                                                           *
 * If you have a bugfix for this file and want to commit it, *
 * please fix the bug in the generator. You can find a link  *
 * to the generator git on tinkerforge.com                   *
 *************************************************************/

#ifndef BRICKLET_HUMIDITY_H
#define BRICKLET_HUMIDITY_H

#include "ip_connection.h"

typedef Device Humidity;

#define HUMIDITY_CALLBACK_HUMIDITY 13
#define HUMIDITY_CALLBACK_ANALOG_VALUE 14
#define HUMIDITY_CALLBACK_HUMIDITY_REACHED 15
#define HUMIDITY_CALLBACK_ANALOG_VALUE_REACHED 16

void humidity_create(Humidity *humidity, const char *uid);

int humidity_get_humidity(Humidity *humidity, uint16_t *ret_humidity);
int humidity_get_analog_value(Humidity *humidity, uint16_t *ret_value);
int humidity_set_humidity_callback_period(Humidity *humidity, uint32_t period);
int humidity_get_humidity_callback_period(Humidity *humidity, uint32_t *ret_period);
int humidity_set_analog_value_callback_period(Humidity *humidity, uint32_t period);
int humidity_get_analog_value_callback_period(Humidity *humidity, uint32_t *ret_period);
int humidity_set_humidity_callback_threshold(Humidity *humidity, char option, int16_t min, int16_t max);
int humidity_get_humidity_callback_threshold(Humidity *humidity, char *ret_option, int16_t *ret_min, int16_t *ret_max);
int humidity_set_analog_value_callback_threshold(Humidity *humidity, char option, uint16_t min, uint16_t max);
int humidity_get_analog_value_callback_threshold(Humidity *humidity, char *ret_option, uint16_t *ret_min, uint16_t *ret_max);
int humidity_set_debounce_period(Humidity *humidity, uint32_t debounce);
int humidity_get_debounce_period(Humidity *humidity, uint32_t *ret_debounce);
int humidity_humidity(Humidity *humidity, uint16_t *ret_humidity);
int humidity_analog_value(Humidity *humidity, uint16_t *ret_value);
int humidity_humidity_reached(Humidity *humidity, uint16_t *ret_humidity);
int humidity_analog_value_reached(Humidity *humidity, uint16_t *ret_value);

void humidity_register_callback(Humidity *humidity, uint8_t cb, void *func);

#endif