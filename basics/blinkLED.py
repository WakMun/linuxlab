import time
import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BCM)

LEDPin     = 23
# GPIO setup
GPIO.setup(LEDPin,     GPIO.OUT)

# Default states for output GPIOs
GPIO.output(LEDPin,     False)

try:
    while True:
        GPIO.output(LEDPin, True)
        time.sleep(0.5)
        GPIO.output(LEDPin, False)
        time.sleep(0.5)
        GPIO.output(LEDPin, True)

except KeyboardInterrupt:
    GPIO.cleanup()

