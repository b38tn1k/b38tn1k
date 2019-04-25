/**
 * Processing Sound Library, Example 5
 * 
 * This sketch shows how to use the FFT class to analyze a stream  
 * of sound. Change the variable bands to get more or less 
 * spectral bands to work with. The smooth_factor variable determines 
 * how much the signal will be smoothed on a scale form 0-1.
 */

import processing.sound.*;

// Declare the processing sound variables 
SoundFile sample;
FFT fft;
AudioDevice device;

// Declare a scaling factor
int scale = 5;

// Define how many FFT bands we want
int bands = 1024;

// declare a drawing variable for calculating rect width
float r_width;
int max = 0;

// Create a smoothing vector
float[] sum = new float[bands];
float[][] positions = new float[100][3]; //(x, y, alpha)

int[] record = new int[100];

PImage bg;
PImage star;


// Create a smoothing factor
float smooth_factor = 0.2;

void setup() {
  size(1080, 1080);
  bg = loadImage("bg.png");
  star = loadImage("star.png");
  star.mask(star);
  imageMode(CENTER);
  for (int i = 0; i <100; i++) {
    record[i] = -1;
  }

  // If the Buffersize is larger than the FFT Size, the FFT will fail
  // so we set Buffersize equal to bands
  device = new AudioDevice(this, 44000, bands);

  // Calculate the width of the rects depending on how many bands we have
  //r_width = width/float(bands);
  r_width = width / 65;

  // Load and play a soundfile and loop it. This has to be called 
  // before the FFT is created.
  sample = new SoundFile(this, "sines.mp3");
  sample.loop();

  // Create and patch the FFT analyzer
  fft = new FFT(this, bands);
  fft.input(sample);
  for (int i = 0; i< 100; i++) {
    positions[i][0] = -1;
  }
}      

void draw() {
  // Set background color, noStroke and fill color
  background(bg);
  fill(0, 0, 255);
  noStroke();

  fft.analyze();
  for (int i = 0; i < 70; i++) {
    // Smooth the FFT data by smoothing factor
    sum[i] += (fft.spectrum[i] - sum[i]) * smooth_factor;
    if (sum[i] > 0.075) {// Draw the rects with a scale factor
      fill(0, 0, 255);
      if (positions[i][0] == -1) {
        positions[i][0] = random(0, 0.6 * height);
      }
      if (i < 17) {
        int stretchwidth = (width - 100) / 16 ;
        positions[i][1] = i*stretchwidth + 50 - (3 * stretchwidth);
        positions[i][2] = 255;
      } else {
        int stretchwidth = (width - 100) / 40;
        positions[i][1] = i*stretchwidth + 50;
        positions[i][2] = 255;
      }
           
      //int j = 0;
      //boolean keepGoing = true;
      //while (keepGoing == true) {
      //  if (i == record[j]) {
      //    keepGoing = false;
      //  }
      //  if (record[j] == -1) {
      //    record[j] = i;
      //    keepGoing = false;
      //  }
      //  if (j == 100) {
      //    keepGoing = false;
      //  }
      //  j++;
      //}
      
      
      // split this into upper and lower stretched over the screen also (or different colored stars)
      if (i > max) {
        max = i;
      }
    }
    if (positions[i][2] > 0) {
      fill(255, 255, 0, positions[i][2]);
      //fill(255, 255, 100, 20);
      ellipse(positions[i][1], positions[i][0], 10, 10);
      println(positions[i][2]);
    }
    positions[i][2]-=5;
  }
  for (int i = 0; i< 100; i++) {
    if (record[i] != -1) {
      print(record[i]);
      print(", ");
    }
    
  }
  println();
  //println(max);
}
