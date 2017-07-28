/* ----------------------------------------------------------------------------------------------------
 * LeFeel (music version), 2017
 * Update: 12/07/17
 * 
 * V1.02
 * Written by Bastien DIDIER
 * more info : http://one-billion-cat.github.com/Humain-Humain/
 *
 * ----------------------------------------------------------------------------------------------------
 */ 

import processing.serial.*; //Import the library
import themidibus.*;
MidiBus MidiBus; // The MidiBus
float map_note;

Serial arduino;
String val;
String[] pos;
String device_port = "/dev/cu.usbmodem1421";

boolean mouseControler = false;

float posX = 0;
float posY = 0;

int touch, touch_note, touch_velocity;
boolean statut_touch;
int textil_layer; //0 ROW //1 COL

boolean noteIsPlaying = false;

void setup(){
  size(500,500);
  
  /********BUS MIDI*************/
  //MidiBus.list();
  MidiBus = new MidiBus(this, -1, "Bus 1");
  
  try{
    arduino = new Serial(this, device_port, 115200);
  } catch (Exception e) {
    println("Device not connected");
    mouseControler = true;
  } 
}

void draw(){
  background(255);
  
  if(mouseControler == false){
    map_serial(arduino);
  } else {
    //TODO if no device debug with mouse
    posX = pmouseX;
    posY = pmouseY;
  }

  int velocity = touch_velocity*10000;
  map_note = map(touch_note, 0,11, 0,127);
  
  println(velocity);
  
  if(statut_touch == true && noteIsPlaying == false){
    MidiBus.sendNoteOn(0, int(map_note), velocity);
    noteIsPlaying = true;
  } else if (statut_touch == false && noteIsPlaying == true){
    MidiBus.sendNoteOff(0, int(map_note), velocity);
    noteIsPlaying = false;
  }  
}

void map_serial(Serial serial){
  if(serial.available() > 0){
    val = serial.readStringUntil('\n');
    pos = split(val, '-');  
  }
  
  try {
    
    //pos[0] 0 / 1 / 2 / 3 / 4 / 5 / 6 / 7 / 8 / 9 / 10 / 11
    //pos[1] TCH / RLD
    //pos[2] ROW / COL
    
    touch = int(pos[0]);
   
    if(pos[1].equals("tch")){
      statut_touch = true;
    } else if (pos[1].equals("rld")){
      statut_touch = false;
    }
    
    if(pos[2].equals("row")){
      textil_layer = 0;
      touch_note = touch;
    } else if (pos[2].equals("col")){
      textil_layer = 1;
      touch_velocity = touch;
    }
  }
  catch (Exception e) {
   println("Setup data incoming : Ignoring…");
  }
}