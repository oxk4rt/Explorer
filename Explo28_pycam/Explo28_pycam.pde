/* 
 * Por:
 * Oscar Espada García
 * oscar.es.garci@gmail.com
 *
 */

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;


PeasyCam camera;
float lookat[];
double distance;
float position[];

Simulator simulator;

PFont font;

void setup() {
 
  size(1000, 700, OPENGL);
  
  lights();
  
  distance = 500.00;
  
  camera = new PeasyCam(this, 0, 0, 0, distance);
  
  simulator = new Simulator(this);
  
  lookat = new float[camera.getLookAt().length];
  lookat = camera.getLookAt();
  distance = camera.getDistance();
  position = new float[camera.getPosition().length];
  
  font = loadFont("URWGothicL-Book-18.vlw");
  
}


void draw(){
  background(0);
  
  lights();
  
  //scale(2.0);
  
  simulator.draw();
  lookat = camera.getLookAt();
  distance = camera.getDistance();
  position = camera.getPosition();
  
  // Restore the base matrix and lighting ready for 2D
  pushMatrix();
  camera.beginHUD();
  
  controls();
  
  camera.endHUD();
  popMatrix();
  
}

void controls(){
  
  stroke(255);
  noFill();
  strokeWeight(0.5);
  line(0, height-height/7.5-1, width,height-height/7.5-1);
  noStroke();
  fill(38,48,68,200);
  rect(0, height-height/7.5, width, height/7.5);
  
  textFont(font, 18);
  
  fill(8,156,201);
  rect(10, height-height/7+15, 117, 30.5);
  fill(255);
  text("CONTROLES", 15, height-height/7+36);
  stroke(255);
  strokeWeight(0.5);
  line(10, height-height/7+47, 127, height-height/7+47);
  noStroke();
  
  
  fill(8,156,201);
  rect(10, height-height/7+55, 117, 30.5);
  fill(255);
  text("EDITOR", 35, height-height/7+76);
  stroke(255);
  strokeWeight(0.5);
  line(10, height-height/7+87, 127, height-height/7+87);
  noStroke();
  
 
  
}

void mousePressed() {
  
  simulator.mousePressed(mouseX, mouseY);

}

