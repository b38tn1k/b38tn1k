Track track; 
float[] wave;
float j = 1;

void setup() {
  size(512, 512, P2D);
  wave = new float[width];
  track = new Track(this, "gh057_w01f.mp3");
  track.play();
}


void draw() {
  
  //println(frameRate);
  //wave
  for (int i = 0; i < width; i++) {
    float amount = map(i, 0, width, 0, PI*j);
    wave[i] = abs(cos(amount));
  }
  for (int i = 0; i < width; i++) {
   stroke(wave[i]*wave[i]*wave[i]*255, 0, 255, 255);
   line(i, 0, i, height/2);
   line(width - i, height/2, width - i, height);
  }
  
  j+= 0.01;
  
  
  //track
  track.updateRMS();
  track.updateFFT();
  j = 10 * (track.rmsSum * track.rmsSum);
  //if (track.latchAmpTriggerRise(0.4) ){
  //  println("hi"); 
  //} else {
  //  println("");
  //}

}
