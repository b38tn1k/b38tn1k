/**
 * This sketch shows how to use the Amplitude class to analyze the changing
 * "loudness" of a stream of sound. In this case an audio sample is analyzed.
 */

import processing.sound.*;

// Declare the processing sound variables 
SoundFile sample;
Amplitude rms;

// Declare a smooth factor to smooth out sudden changes in amplitude.
// With a smooth factor of 1, only the last measured amplitude is used for the
// visualisation, which can lead to very abrupt changes. As you decrease the
// smooth factor towards 0, the measured amplitudes are averaged across frames,
// leading to more pleasant gradual changes
//float smoothingFactor = 0.25;
float smoothingFactor = 0.15;

// Used for storing the smoothed amplitude value
float sum;

int num = 200;
int range = 50;

float[] ax = new float[num];
float[] ay = new float[num]; 
float [][] aliens = new float[200][2];
int count = 100;
int timer;

PImage bg;
PImage img;
PImage imgMask;
PImage boss;
PImage bossMask;
PGraphics pg;


int r1, r2, r3, r4, r5, r6, r7, r8;
float angle = 0;

PShader shade;

public void setup() {
  size(1080, 1080, P2D);
  pg = createGraphics(1080, 1080, P2D);
  //frameRate(24);
  shade = loadShader("channels.glsl");
  stroke(255, 0, 0);

  //Load and play a soundfile and loop it
  sample = new SoundFile(this, "gh057_w01f.mp3");
  sample.loop();

  // Create and patch the rms tracker
  rms = new Amplitude(this);
  rms.input(sample);
  for(int i = 0; i < num; i++) {
    ax[i] = width/2;
    ay[i] = height/2;
  }
  
  for(int i = 0; i < 200; i++) {
    aliens[i][0] = -1.0;
  }
  bg = loadImage("bg1080.png");
  img = loadImage("bg1080.png");
  //imgMask = loadImage("bg1080mask.png");
  imgMask = loadImage("bg1080maskinv.png");
  img.mask(imgMask);
  
  boss = loadImage("boss.png");
  boss.mask(boss);
  imageMode(CENTER);
}      

public void draw() {
  
  println(frameRate);
  // Set background color, noStroke and fill color
  //background(125, 255, 125);
  background(bg);
  noStroke();
  
  for (int i = 0; i < 200; i++) {
   if (aliens[i][0] != -1.0) {
     image(boss, aliens[i][0], aliens[i][1], 30, 30);
   }
  }
  
  // smooth the rms data by smoothing factor
  sum += (rms.analyze() - sum) * smoothingFactor;  
  // rms.analyze() return a value between 0 and 1. It's
  // scaled to height/2 and then multiplied by a fixed scale factor
  float rms_scaled = sum * (height/5) * 5;
  float rms_scaled2 = sum * (height/7) * 5;
  float rms_scaled3 = sum * (height/9) * 5;
  float rms_scaled4 = sum * (height/11) * 5;
  float rms_scaled5 = sum * (height/13) * 5;
  float rms_scaled6 = sum * (height/15) * 5;
  float rms_scaled7 = sum * (height/17) * 5; //make each subsequent radius dampened more, make the center move in a small circle?
  float rms_scaled8 = sum * (height/19) * 5;
  float rms_scaled9 = sum * (height/21) * 5;
  float rms_scaled10 = sum * (height/23) * 5;
  float rms_scaled11 = sum * (height/25) * 5;
  float rms_scaled12 = sum * (height/27) * 5;
  float rms_scaled13 = sum * (height/29) * 5;
  float rms_scaled14 = sum * (height/31) * 5;
  float rms_scaled15 = sum * (height/33) * 5;
  float rms_scaled16 = sum * (height/35) * 5;
  float rms_scaled17 = sum * (height/37) * 5;
  float rms_scaled18 = sum * (height/39) * 5;
  float rms_scaled19 = sum * (height/41) * 5;
  float rms_scaled20 = sum * (height/43) * 5;
  float rms_scaled21 = sum * (height/45) * 5;
  float rms_scaled22 = sum * (height/47) * 5;
  float rms_scaled23 = sum * (height/49) * 5;
  float rms_scaled24 = sum * (height/51) * 5;
  
  
  int cx = int(width/2 + 10 * sin(angle));
  int cy = int(height/2 + 10 * cos(angle));
  angle += 0.01;
  // We draw a circle whose size is coupled to the audio analysis
  fill(255, 0, 150);
  ellipse(cx, cy, rms_scaled, rms_scaled);
  fill(125, 255, 125);
  cx = int(width/2 + 15 * sin(angle) * sum);
  cy = int(height/2 + 15 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled2, rms_scaled2);
  
  fill(250, 0, 145);
  cx = int(width/2 + 20 * sin(angle) * sum);
  cy = int(height/2 + 20 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled3, rms_scaled3);
  fill(120, 250, 120);
  cx = int(width/2 + 25 * sin(angle) * sum);
  cy = int(height/2 + 25 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled4, rms_scaled4);
  
  fill(245, 0, 140);
  cx = int(width/2 + 30 * sin(angle) * sum);
  cy = int(height/2 + 30 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled5, rms_scaled5);
  fill(115, 245, 115);
  cx = int(width/2 + 35 * sin(angle) * sum);
  cy = int(height/2 + 35 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled6, rms_scaled6);
  
  fill(240, 0, 135);
  cx = int(width/2 + 40 * sin(angle) * sum);
  cy = int(height/2 + 40 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled7, rms_scaled7);
  fill(110, 240, 110);
  cx = int(width/2 + 45 * sin(angle) * sum);
  cy = int(height/2 + 45 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled8, rms_scaled8);
  
  fill(235, 0, 130);
  cx = int(width/2 + 50 * sin(angle) * sum);
  cy = int(height/2 + 50 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled9, rms_scaled9);
  fill(105, 235, 105);
  cx = int(width/2 + 55 * sin(angle) * sum);
  cy = int(height/2 + 55 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled10, rms_scaled10);
  
  fill(230, 0, 125);
  cx = int(width/2 + 60 * sin(angle) * sum);
  cy = int(height/2 + 60 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled11, rms_scaled11);
  fill(100, 230, 100);
  cx = int(width/2 + 65 * sin(angle) * sum);
  cy = int(height/2 + 65 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled12, rms_scaled12);
  
  fill(225, 0, 120);
  cx = int(width/2 + 70 * sin(angle) * sum);
  cy = int(height/2 + 70 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled13, rms_scaled13);
  fill(95, 225, 95);
  cx = int(width/2 + 75 * sin(angle) * sum);
  cy = int(height/2 + 75 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled14, rms_scaled14);
  
  fill(220, 0, 115);
  cx = int(width/2 + 80 * sin(angle) * sum);
  cy = int(height/2 + 80 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled15, rms_scaled15);
  fill(90, 220, 90);
  cx = int(width/2 + 85 * sin(angle) * sum);
  cy = int(height/2 + 85 * cos(angle) * sum);
  ellipse(cx, cy, rms_scaled16, rms_scaled16);
 
  
  for(int i = 1; i < num; i++) {
    ax[i-1] = ax[i];
    ay[i-1] = ay[i];
  }
  
  image(img, width/2, height/2);
  
  if (rms_scaled > ((5 * height) /8)) {
    // Put a new value at the end of the array
    ax[num-1] += random(-range, range);
    ay[num-1] += random(-range, range);
  
    // Constrain all points to the screen
    ax[num-1] = constrain(ax[num-1], 0, width);
    ay[num-1] = constrain(ay[num-1], 0, height);
    fill(255, 255, 0);
    // Draw a line connecting the points
    for(int i=1; i<num; i++) {    
      float val = float(i)/num * 204.0 + 51 + 100;
      strokeWeight(8);
      stroke(val, val, val);
      line(ax[i-1], ay[i-1], ax[i], ay[i]);
    }
    line(cx, cy, ax[1], ay[1]);
    
    for(int i=1; i<num; i++) {    
      float val = float(i)/num * 204.0 + 51 + 100;
      strokeWeight(4);
      stroke(255, 255, 0);
      line(ax[i-1], ay[i-1], ax[i], ay[i]);
    }
    line(cx, cy, ax[1], ay[1]);
    for(int i=1; i<num; i++) {    
      float val = float(i)/num * 204.0 + 51 + 100;
      strokeWeight(1);
      stroke(0, 0, val);
      line(ax[i-1], ay[i-1], ax[i], ay[i]);
    }
    line(cx, cy, ax[1], ay[1]);
  }
  
}
