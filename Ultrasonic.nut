/*
  Ultrasonic.cpp - Library for HC-SR04 Ultrasonic Ranging Module.

  Created by ITead studio. Apr 20, 2010.
  iteadstudio.com
  Ported for Esquilo 20161204 Leeland Heins
*/

class Ultrasonic
{
    trigPin = null;
    echoPin = null;

    epChannel = null;

    const CM = 1;  // Centimeters
    const INC = 0;  // Inches

    constructor(TP, EP, ch)
    {
        trigPin = GPIO(TP);  // HC-SR04 trigger pin (output)
        echoPin = Capture(EP);  // HC-SR04 echo pin (input)
        epChannel = ch;
        trigPin.output();
    }
};

function Ultrasonic::Timing()
{
    local duration;

    trigPin.low();
    udelay(2);
    trigPin.high();
    udelay(10);
    trigPin.low();

    echoPin.arm(epChannel, CAPTURE_EDGE_RISING);
    duration = echoPin.read(epChannel);

    return duration;
}

function Ultrasonic::Ranging(sys)
{
    local duration;
    local distance_cm;
    local distance_inc;

    duration = Timing();

    if (sys) {
        distance_cm = duration / 29 / 2;
        return distance_cm;
    } else {
        distance_inc = duration / 74 / 2;
        return distance_inc;
    }
}

