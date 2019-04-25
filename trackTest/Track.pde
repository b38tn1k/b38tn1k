import processing.sound.*;
/* Track provides a simple interface to RMS, FFT and 
playback of an audio sample for music visulisation*/

class Track {
  // Properties
  SoundFile sample;
  // RMS 
  Amplitude rms;
  float rmsDamp, rmsSum;
  boolean rmsRiseTrigger;
  // FFT
  FFT fft;
  AudioDevice device;
  int fftBands = 1024;
  float fftDamp;
  float fftSum[] = new float[fftBands];
  //Constructor
  Track (PApplet parent, String name) {
    this.device = new AudioDevice(parent, 44000, this.fftBands); //lock buffer size to fft
    this.rmsDamp = 0.15;
    this.fftDamp = 0.15;
    this.sample = new SoundFile(parent, name);
    this.rms = new Amplitude(parent);
    this.fft = new FFT(parent, this.fftBands);
  }
  
  void play() {
    this.sample.loop();
    this.rms.input(this.sample);
    this.fft.input(this.sample);
  }
  
  void updateRMS() {
    this.rmsSum += (this.rms.analyze() - this.rmsSum) * this.rmsDamp;
  }
  
  void updateFFT() {
    for (int i = 0; i < this.fftBands; i++) {
      this.fftSum[i] += (this.fft.spectrum[i] - this.fftSum[i]) * this.fftDamp;
    }
  }
  
  float getAmplitude() {
    return this.rmsSum;
  }
  
  boolean ampTrigger(float threshold) {
    if (this.rmsSum > threshold) {
      return true;
    } else {
      return false;
    }
  }
  
   boolean latchAmpTriggerRise(float threshold) {
     if (this.rmsSum > threshold) {
       if (this.rmsRiseTrigger == false) {
         this.rmsRiseTrigger = true;
         return true;
       } else { 
         return false;
       }
     } else {
       this.rmsRiseTrigger = false;
       return false;
     }
   }
  
   //boolean latchAmpTriggerFall() {}
  
}
