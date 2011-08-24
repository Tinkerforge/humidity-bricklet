/*************************************************************
 * This file was automatically generated on 2011-08-23.      *
 *                                                           *
 * If you have a bugfix for this file and want to commit it, *
 * please fix the bug in the generator. You can find a link  *
 * to the generator git on tinkerforge.com                   *
 *************************************************************/

#include "bricklet_humidity.h"

#include <string.h>

#define TYPE_GET_HUMIDITY 1
#define TYPE_GET_ANALOG_VALUE 2
#define TYPE_SET_HUMIDITY_CALLBACK_PERIOD 3
#define TYPE_GET_HUMIDITY_CALLBACK_PERIOD 4
#define TYPE_SET_ANALOG_VALUE_CALLBACK_PERIOD 5
#define TYPE_GET_ANALOG_VALUE_CALLBACK_PERIOD 6
#define TYPE_SET_HUMIDITY_CALLBACK_THRESHOLD 7
#define TYPE_GET_HUMIDITY_CALLBACK_THRESHOLD 8
#define TYPE_SET_ANALOG_VALUE_CALLBACK_THRESHOLD 9
#define TYPE_GET_ANALOG_VALUE_CALLBACK_THRESHOLD 10
#define TYPE_SET_DEBOUNCE_PERIOD 11
#define TYPE_GET_DEBOUNCE_PERIOD 12
#define TYPE_HUMIDITY 13
#define TYPE_ANALOG_VALUE 14
#define TYPE_HUMIDITY_REACHED 15
#define TYPE_ANALOG_VALUE_REACHED 16

typedef void (*humidity_func_t)(uint16_t);
typedef void (*analog_value_func_t)(uint16_t);
typedef void (*humidity_reached_func_t)(uint16_t);
typedef void (*analog_value_reached_func_t)(uint16_t);

#ifdef _MSC_VER
	#pragma pack(push)
	#pragma pack(1)

	#define PACKED
#else
	#define PACKED __attribute__((packed))
#endif

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetHumidity;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint16_t humidity;
} PACKED GetHumidityReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetAnalogValue;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint16_t value;
} PACKED GetAnalogValueReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint32_t period;
} PACKED SetHumidityCallbackPeriod;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetHumidityCallbackPeriod;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint32_t period;
} PACKED GetHumidityCallbackPeriodReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint32_t period;
} PACKED SetAnalogValueCallbackPeriod;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetAnalogValueCallbackPeriod;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint32_t period;
} PACKED GetAnalogValueCallbackPeriodReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	char option;
	int16_t min;
	int16_t max;
} PACKED SetHumidityCallbackThreshold;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetHumidityCallbackThreshold;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	char option;
	int16_t min;
	int16_t max;
} PACKED GetHumidityCallbackThresholdReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	char option;
	uint16_t min;
	uint16_t max;
} PACKED SetAnalogValueCallbackThreshold;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetAnalogValueCallbackThreshold;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	char option;
	uint16_t min;
	uint16_t max;
} PACKED GetAnalogValueCallbackThresholdReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint32_t debounce;
} PACKED SetDebouncePeriod;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetDebouncePeriod;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint32_t debounce;
} PACKED GetDebouncePeriodReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint16_t humidity;
} PACKED HumidityCallback;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint16_t value;
} PACKED AnalogValueCallback;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint16_t humidity;
} PACKED HumidityReachedCallback;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint16_t value;
} PACKED AnalogValueReachedCallback;

#ifdef _MSC_VER
	#pragma pack(pop)
#endif

int humidity_get_humidity(Humidity *humidity, uint16_t *ret_humidity) {
	if(humidity->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(humidity);

	humidity->answer.type = TYPE_GET_HUMIDITY;
	humidity->answer.length = sizeof(GetHumidityReturn);
	GetHumidity gh;
	gh.stack_id = humidity->stack_id;
	gh.type = TYPE_GET_HUMIDITY;
	gh.length = sizeof(GetHumidity);

	ipcon_device_write(humidity, (char *)&gh, sizeof(GetHumidity));

	if(ipcon_answer_sem_wait_timeout(humidity) != 0) {
		ipcon_sem_post_write(humidity);
		return E_TIMEOUT;
	}

	GetHumidityReturn *ghr = (GetHumidityReturn *)humidity->answer.buffer;
	*ret_humidity = ghr->humidity;

	ipcon_sem_post_write(humidity);

	return E_OK;
}

int humidity_get_analog_value(Humidity *humidity, uint16_t *ret_value) {
	if(humidity->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(humidity);

	humidity->answer.type = TYPE_GET_ANALOG_VALUE;
	humidity->answer.length = sizeof(GetAnalogValueReturn);
	GetAnalogValue gav;
	gav.stack_id = humidity->stack_id;
	gav.type = TYPE_GET_ANALOG_VALUE;
	gav.length = sizeof(GetAnalogValue);

	ipcon_device_write(humidity, (char *)&gav, sizeof(GetAnalogValue));

	if(ipcon_answer_sem_wait_timeout(humidity) != 0) {
		ipcon_sem_post_write(humidity);
		return E_TIMEOUT;
	}

	GetAnalogValueReturn *gavr = (GetAnalogValueReturn *)humidity->answer.buffer;
	*ret_value = gavr->value;

	ipcon_sem_post_write(humidity);

	return E_OK;
}

int humidity_set_humidity_callback_period(Humidity *humidity, uint32_t period) {
	if(humidity->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(humidity);

	SetHumidityCallbackPeriod shcp;
	shcp.stack_id = humidity->stack_id;
	shcp.type = TYPE_SET_HUMIDITY_CALLBACK_PERIOD;
	shcp.length = sizeof(SetHumidityCallbackPeriod);
	shcp.period = period;

	ipcon_device_write(humidity, (char *)&shcp, sizeof(SetHumidityCallbackPeriod));

	ipcon_sem_post_write(humidity);

	return E_OK;
}

int humidity_get_humidity_callback_period(Humidity *humidity, uint32_t *ret_period) {
	if(humidity->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(humidity);

	humidity->answer.type = TYPE_GET_HUMIDITY_CALLBACK_PERIOD;
	humidity->answer.length = sizeof(GetHumidityCallbackPeriodReturn);
	GetHumidityCallbackPeriod ghcp;
	ghcp.stack_id = humidity->stack_id;
	ghcp.type = TYPE_GET_HUMIDITY_CALLBACK_PERIOD;
	ghcp.length = sizeof(GetHumidityCallbackPeriod);

	ipcon_device_write(humidity, (char *)&ghcp, sizeof(GetHumidityCallbackPeriod));

	if(ipcon_answer_sem_wait_timeout(humidity) != 0) {
		ipcon_sem_post_write(humidity);
		return E_TIMEOUT;
	}

	GetHumidityCallbackPeriodReturn *ghcpr = (GetHumidityCallbackPeriodReturn *)humidity->answer.buffer;
	*ret_period = ghcpr->period;

	ipcon_sem_post_write(humidity);

	return E_OK;
}

int humidity_set_analog_value_callback_period(Humidity *humidity, uint32_t period) {
	if(humidity->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(humidity);

	SetAnalogValueCallbackPeriod savcp;
	savcp.stack_id = humidity->stack_id;
	savcp.type = TYPE_SET_ANALOG_VALUE_CALLBACK_PERIOD;
	savcp.length = sizeof(SetAnalogValueCallbackPeriod);
	savcp.period = period;

	ipcon_device_write(humidity, (char *)&savcp, sizeof(SetAnalogValueCallbackPeriod));

	ipcon_sem_post_write(humidity);

	return E_OK;
}

int humidity_get_analog_value_callback_period(Humidity *humidity, uint32_t *ret_period) {
	if(humidity->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(humidity);

	humidity->answer.type = TYPE_GET_ANALOG_VALUE_CALLBACK_PERIOD;
	humidity->answer.length = sizeof(GetAnalogValueCallbackPeriodReturn);
	GetAnalogValueCallbackPeriod gavcp;
	gavcp.stack_id = humidity->stack_id;
	gavcp.type = TYPE_GET_ANALOG_VALUE_CALLBACK_PERIOD;
	gavcp.length = sizeof(GetAnalogValueCallbackPeriod);

	ipcon_device_write(humidity, (char *)&gavcp, sizeof(GetAnalogValueCallbackPeriod));

	if(ipcon_answer_sem_wait_timeout(humidity) != 0) {
		ipcon_sem_post_write(humidity);
		return E_TIMEOUT;
	}

	GetAnalogValueCallbackPeriodReturn *gavcpr = (GetAnalogValueCallbackPeriodReturn *)humidity->answer.buffer;
	*ret_period = gavcpr->period;

	ipcon_sem_post_write(humidity);

	return E_OK;
}

int humidity_set_humidity_callback_threshold(Humidity *humidity, char option, int16_t min, int16_t max) {
	if(humidity->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(humidity);

	SetHumidityCallbackThreshold shct;
	shct.stack_id = humidity->stack_id;
	shct.type = TYPE_SET_HUMIDITY_CALLBACK_THRESHOLD;
	shct.length = sizeof(SetHumidityCallbackThreshold);
	shct.option = option;
	shct.min = min;
	shct.max = max;

	ipcon_device_write(humidity, (char *)&shct, sizeof(SetHumidityCallbackThreshold));

	ipcon_sem_post_write(humidity);

	return E_OK;
}

int humidity_get_humidity_callback_threshold(Humidity *humidity, char *ret_option, int16_t *ret_min, int16_t *ret_max) {
	if(humidity->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(humidity);

	humidity->answer.type = TYPE_GET_HUMIDITY_CALLBACK_THRESHOLD;
	humidity->answer.length = sizeof(GetHumidityCallbackThresholdReturn);
	GetHumidityCallbackThreshold ghct;
	ghct.stack_id = humidity->stack_id;
	ghct.type = TYPE_GET_HUMIDITY_CALLBACK_THRESHOLD;
	ghct.length = sizeof(GetHumidityCallbackThreshold);

	ipcon_device_write(humidity, (char *)&ghct, sizeof(GetHumidityCallbackThreshold));

	if(ipcon_answer_sem_wait_timeout(humidity) != 0) {
		ipcon_sem_post_write(humidity);
		return E_TIMEOUT;
	}

	GetHumidityCallbackThresholdReturn *ghctr = (GetHumidityCallbackThresholdReturn *)humidity->answer.buffer;
	*ret_option = ghctr->option;
	*ret_min = ghctr->min;
	*ret_max = ghctr->max;

	ipcon_sem_post_write(humidity);

	return E_OK;
}

int humidity_set_analog_value_callback_threshold(Humidity *humidity, char option, uint16_t min, uint16_t max) {
	if(humidity->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(humidity);

	SetAnalogValueCallbackThreshold savct;
	savct.stack_id = humidity->stack_id;
	savct.type = TYPE_SET_ANALOG_VALUE_CALLBACK_THRESHOLD;
	savct.length = sizeof(SetAnalogValueCallbackThreshold);
	savct.option = option;
	savct.min = min;
	savct.max = max;

	ipcon_device_write(humidity, (char *)&savct, sizeof(SetAnalogValueCallbackThreshold));

	ipcon_sem_post_write(humidity);

	return E_OK;
}

int humidity_get_analog_value_callback_threshold(Humidity *humidity, char *ret_option, uint16_t *ret_min, uint16_t *ret_max) {
	if(humidity->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(humidity);

	humidity->answer.type = TYPE_GET_ANALOG_VALUE_CALLBACK_THRESHOLD;
	humidity->answer.length = sizeof(GetAnalogValueCallbackThresholdReturn);
	GetAnalogValueCallbackThreshold gavct;
	gavct.stack_id = humidity->stack_id;
	gavct.type = TYPE_GET_ANALOG_VALUE_CALLBACK_THRESHOLD;
	gavct.length = sizeof(GetAnalogValueCallbackThreshold);

	ipcon_device_write(humidity, (char *)&gavct, sizeof(GetAnalogValueCallbackThreshold));

	if(ipcon_answer_sem_wait_timeout(humidity) != 0) {
		ipcon_sem_post_write(humidity);
		return E_TIMEOUT;
	}

	GetAnalogValueCallbackThresholdReturn *gavctr = (GetAnalogValueCallbackThresholdReturn *)humidity->answer.buffer;
	*ret_option = gavctr->option;
	*ret_min = gavctr->min;
	*ret_max = gavctr->max;

	ipcon_sem_post_write(humidity);

	return E_OK;
}

int humidity_set_debounce_period(Humidity *humidity, uint32_t debounce) {
	if(humidity->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(humidity);

	SetDebouncePeriod sdp;
	sdp.stack_id = humidity->stack_id;
	sdp.type = TYPE_SET_DEBOUNCE_PERIOD;
	sdp.length = sizeof(SetDebouncePeriod);
	sdp.debounce = debounce;

	ipcon_device_write(humidity, (char *)&sdp, sizeof(SetDebouncePeriod));

	ipcon_sem_post_write(humidity);

	return E_OK;
}

int humidity_get_debounce_period(Humidity *humidity, uint32_t *ret_debounce) {
	if(humidity->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(humidity);

	humidity->answer.type = TYPE_GET_DEBOUNCE_PERIOD;
	humidity->answer.length = sizeof(GetDebouncePeriodReturn);
	GetDebouncePeriod gdp;
	gdp.stack_id = humidity->stack_id;
	gdp.type = TYPE_GET_DEBOUNCE_PERIOD;
	gdp.length = sizeof(GetDebouncePeriod);

	ipcon_device_write(humidity, (char *)&gdp, sizeof(GetDebouncePeriod));

	if(ipcon_answer_sem_wait_timeout(humidity) != 0) {
		ipcon_sem_post_write(humidity);
		return E_TIMEOUT;
	}

	GetDebouncePeriodReturn *gdpr = (GetDebouncePeriodReturn *)humidity->answer.buffer;
	*ret_debounce = gdpr->debounce;

	ipcon_sem_post_write(humidity);

	return E_OK;
}

int humidity_callback_humidity(Humidity *humidity, const unsigned char *buffer) {
	HumidityCallback *hc = (HumidityCallback *)buffer;
	((humidity_func_t)humidity->callbacks[hc->type])(hc->humidity);
	return sizeof(HumidityCallback);
}

int humidity_callback_analog_value(Humidity *humidity, const unsigned char *buffer) {
	AnalogValueCallback *avc = (AnalogValueCallback *)buffer;
	((analog_value_func_t)humidity->callbacks[avc->type])(avc->value);
	return sizeof(AnalogValueCallback);
}

int humidity_callback_humidity_reached(Humidity *humidity, const unsigned char *buffer) {
	HumidityReachedCallback *hrc = (HumidityReachedCallback *)buffer;
	((humidity_reached_func_t)humidity->callbacks[hrc->type])(hrc->humidity);
	return sizeof(HumidityReachedCallback);
}

int humidity_callback_analog_value_reached(Humidity *humidity, const unsigned char *buffer) {
	AnalogValueReachedCallback *avrc = (AnalogValueReachedCallback *)buffer;
	((analog_value_reached_func_t)humidity->callbacks[avrc->type])(avrc->value);
	return sizeof(AnalogValueReachedCallback);
}

void humidity_register_callback(Humidity *humidity, uint8_t cb, void *func) {
    humidity->callbacks[cb] = func;
}

void humidity_create(Humidity *humidity, const char *uid) {
	ipcon_device_create(humidity, uid);

	humidity->device_callbacks[TYPE_HUMIDITY] = humidity_callback_humidity;
	humidity->device_callbacks[TYPE_ANALOG_VALUE] = humidity_callback_analog_value;
	humidity->device_callbacks[TYPE_HUMIDITY_REACHED] = humidity_callback_humidity_reached;
	humidity->device_callbacks[TYPE_ANALOG_VALUE_REACHED] = humidity_callback_analog_value_reached;
}
