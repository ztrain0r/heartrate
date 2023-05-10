#include <Arduino.h>
#include <WiFiClientSecure.h>
#include <SPIFFS.h>
#include "at_client.h"
#include "constants.h"

// KS0015 Keyestudio Pulse Rate Monitor
// WIRING:
// signal S -> A4 (pin 36)
// positive pin V -> A19 (5V)
// negative pin G -> J1 (GND)

#define LED 2
int newReading = 0;
int oldReading = 0;
double timeCount = 0.0;
int count = 0;
int value = 0;
int sensorPin = 39; 

void setup() {
  // put your setup code here, to run once:
    const auto *esp32 = new AtSign("@");  // ESP32 ATSIGN, SENDS DATA
    const auto *java = new AtSign("@b"); // APP ATSIGN, RECEIVES DATA
    
    // reads the keys on the ESP32
    const auto keys = keys_reader::read_keys(*esp32); 
    
    // creates the AtClient object (allows us to run operations)
    auto *at_client = new AtClient(*esp32, keys);  
    
    // pkam authenticate into our atServer
    at_client->pkam_authenticate(SSID, PASSWORD);

    std::cout << "Put finger on sensor!" << std::endl;

    // from doc. setup sesnor
    pinMode(sensorPin, INPUT);
    Serial.begin(115200);
    // usleep(5000000);
    delay(5000);

    while (true) { 
      int newReading = analogRead(sensorPin);
        // if the ADC value is less than ~100,
        // the user does not have their finger on the sensor
      if (newReading < 100) {
        std::cout << "ERROR: finger not on monitor" << std::endl;
        break;
      }

      if (oldReading > newReading) {
        pinMode(LED, OUTPUT);
        digitalWrite(LED, HIGH); // flashes ESP32 LED per beat
        std::cout << "beat" << std::endl;
        count += 1;
        // usleep(100000);
        delay(100);
        digitalWrite(LED, LOW);
      }
        
      std::cout << " "; // print empty line if no heart beat is read
        
      // check for heart beat every 0.25 seconds
      //usleep(250000);
      delay(250);
      timeCount += 0.25;
      oldReading = newReading;

      // measure heart rate for 15 seconds
      if (timeCount >= 15) {
        value = count * 4;
        // calculate heart rate using beat count from 15 seconds (15 * 4 = 60 seconds = BPM)
        break;
      }
    }
    std::cout<< "COUNT: " << count << " beats" << std::endl;
    std::cout<< "Heart rate: " << value << "bpm" << std::endl;

    std::string svalue = std::to_string(value);
    const auto *at_key = new AtKey("heartrate", esp32, java); // send heartrate data from esp32 to java

    at_client->put_ak(*at_key, svalue); // send heartrate sensor value to java via atsign
}

void loop() {
  // TO CHECK IF SENSOR IS IN CORRECT POSITION: 
  // uncomment and upload this code. Adjust top light until
  // reading becomes around < 100 when finger not on sensor

  // double alpha = 0.75;
  // int period = 20;
  // double change = 0.0;
  // static double oldValue = 0;
  // static double oldChange = 0;
  // int rawValue = analogRead(sensorPin);
  // double value = alpha * oldValue + (1 - alpha) * rawValue;
  // Serial.print(rawValue);
  // Serial.print(",");
  // Serial.println(value);
  // oldValue = value;
  // delay(period);
}