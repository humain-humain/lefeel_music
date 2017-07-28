/* ----------------------------------------------------------------------------------------------------
 * LeFeel (music version), 2017
 * Update: 28/07/17
 * 
 * V1.05
 * Written by Bastien DIDIER
 * more info : https://github.com/humain-humain/lefeel
 *
 * ----------------------------------------------------------------------------------------------------
 */ 
 
#include <Wire.h>
#include "Adafruit_MPR121.h"

// You can have up to 4 on one i2c bus
Adafruit_MPR121 row = Adafruit_MPR121();
Adafruit_MPR121 col = Adafruit_MPR121();

// Keeps track of the last pins touched
// so we know when buttons are 'released'
uint16_t lasttouchedROW = 0;
uint16_t currtouchedROW = 0;

uint16_t lasttouchedCOL = 0;
uint16_t currtouchedCOL = 0;

//String PosX = "0";
//String PosY = "0";

void setup() {
  Serial.begin(115200);

  while (!Serial) { // needed to keep leonardo/micro from starting too fast!
    delay(10);
  }
  
  Serial.println("Adafruit MPR121 Capacitive Touch sensor test"); 
  
  // Default address is 0x5A, if tied to 3.3V its 0x5B
  // If tied to SDA its 0x5C and if SCL then 0x5D
  if (!row.begin(0x5A)) {
    Serial.println("MPR121 : ROW not found, check wiring?");
    while (1);
  }
  Serial.println("MPR121 : ROW found!");
  
  if (!col.begin(0x5B)) {
    Serial.println("MPR121 : COL not found, check wiring?");
    while (1);
  }
  Serial.println("MPR121 : COL found!");
}

void loop() {
  // Get the currently touched pads
  currtouchedROW = row.touched();
  currtouchedCOL = col.touched();
  
  for (uint8_t i=0; i<12; i++) {
    // it if ROW *is* touched and *wasnt* touched before, alert!
    if ((currtouchedROW & _BV(i)) && !(lasttouchedROW & _BV(i)) ) {
      Serial.println(String(i)+"-tch-row-");
    }
    // if it ROW *was* touched and now *isnt*, alert!
    if (!(currtouchedROW & _BV(i)) && (lasttouchedROW & _BV(i)) ) {
      Serial.println(String(i)+"-rld-row-");
    }
  }

  for (uint8_t i=0; i<12; i++) {
    // it if COL *is* touched and *wasnt* touched before, alert!
    if ((currtouchedCOL & _BV(i)) && !(lasttouchedCOL & _BV(i)) ) {
      Serial.println(String(i)+"-tch-col-");    
    }
    // if it COL *was* touched and now *isnt*, alert!
    if (!(currtouchedCOL & _BV(i)) && (lasttouchedCOL & _BV(i)) ) {
      Serial.println(String(i)+"-rld-col-");
    }
  }

  // reset our state
  lasttouchedROW = currtouchedROW;
  lasttouchedCOL = currtouchedCOL;

  //comment out this line for detailed data from the sensor!
  return;

  // ROW debugging info…
  Serial.println("ROW Debugging info…");
  mpr121_detailed_data(row);

  // COL debugging info…
  Serial.println("COL Debugging info…");
  mpr121_detailed_data(col);

  // put a delay so it isn't overwhelming
  delay(100);
}

void mpr121_detailed_data(Adafruit_MPR121 mpr121){

  //Serial.println(mpr121+" Debugging info…");
  
  // MPR121 debugging info…
  Serial.print("\t\t\t\t\t\t\t\t\t\t\t\t\t 0x"); Serial.println(mpr121.touched(), HEX);
  Serial.print("Filt: ");
  for (uint8_t i=0; i<12; i++) {
    Serial.print(mpr121.filteredData(i)); Serial.print("\t");
  }
  Serial.println();
  Serial.print("Base: ");
  for (uint8_t i=0; i<12; i++) {
    Serial.print(mpr121.baselineData(i)); Serial.print("\t");
  }
  Serial.println();
}
