/* ----------------------------------------------------------------------------------------------------
 * LeFeel (music version), 2017
 * Update: 28/07/17
 * 
 * V1.02
 * Written by Bastien DIDIER
 * more info : https://github.com/humain-humain/lefeel_music
 *
 * ----------------------------------------------------------------------------------------------------
 */ 

import processing.serial.*; //Import the library
import themidibus.*;
MidiBus MidiBus; // The MidiBus
float map_note, velocity;

Serial arduino;
String val;
String[] pos;
String device_port = "/dev/cu.usbmodem1421";

boolean mouseControler = false;

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
    velocity = map(touch_velocity, 0,11, 10,100);
    map_note = map(touch_note, 0,11, 0,127);
  } else {
    //TODO if no device debug with mouse
    velocity = map(pmouseY, 0,height, 10,100);
    map_note = map(pmouseX, 0,width, 0,127);
    
  }
  println(map_note);
  
  if(statut_touch == true && noteIsPlaying == false){
    MidiBus.sendNoteOn(0, int(map_note), int(velocity));
    noteIsPlaying = true;
  } else if (statut_touch == false && noteIsPlaying == true){
    MidiBus.sendNoteOff(0, int(map_note), int(velocity));
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

void mousePressed(){
  if(mouseControler == true){
    statut_touch = true;
  }
}

void mouseReleased(){
  if(mouseControler == true){
    statut_touch = false;
  }
}