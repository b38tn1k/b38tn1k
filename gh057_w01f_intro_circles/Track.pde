import processing.sound.*;
/* Track provides a simple interface to RMS, FFT and 
playback of an audio sample for music visulisation*/

class Track {
  // Properties
  SoundFile sample;
  // RMS 
  Amplitude rms;
  float rmsDamp, rmsSum;
  // FFT
  FFT fft;
  AudioDevice device;
  int fftBands = 1024;

  //Constructor
  Track (PApplet parent, String name) {
    this.rmsDamp = 0.15;
    this.sample = new SoundFile(parent, name);
    this.rms = new Amplitude(parent);
  }
  
  void play() {
    this.sample.loop();
    this.rms.input(this.sample);
  }
  
  void update () {
    this.rmsSum += (this.rms.analyze() - this.rmsSum) * this.rmsDamp;
  }
  
  float getAmplitude() {
    return this.rmsSum;
  }
  
  boolean amplitudeTrigger(float threshold) {
    if (this.rmsSum > threshold) {
      return true;
    } else {
      return false;
    }
  }
  
}
