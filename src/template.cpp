#ifdef RECODEX_ARDUINO_DEV
// behold, defensive programing against ReCoDex
// whyyy? why do you force me to do this? go away, Arduino devs:
// https://github.com/arduino/arduino-cli/blob/b9edb782a265b99878b4bce489c1751c4dcbee61/internal/arduino/builder/sketch.go#L93-L96
#define ARDUINO_PATH_HACK <Arduino.h>
#include ARDUINO_PATH_HACK
#endif
#include "funshield.h"

void
setup() {
    // TODO: setup
}

void
loop() {
    // TODO: loop
}
