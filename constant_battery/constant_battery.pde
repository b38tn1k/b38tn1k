PImage battery;
PGraphics pg;
float mix = -0.01;

void setup() {
  size(300, 150, P2D);
  noSmooth();
  //pg = createGraphics(300, 150);
  battery = loadImage("battery.png");
  background(color(255, 0, 255, 0));
  image(battery, 0, 0);
  noStroke();
}
int count = -1;
void draw() {
  //clear out old battery
  if (mix <= 1.01) {
    String s ="battery_" + count + ".png";
    saveFrame(s);
    mix+=0.01;
    count += 1;
  }
  clear();
  background(color(255, 0, 255, 0));
  fill(255, 255, 255, 255);
  rect(40, 140, 70, -125);
  //mix = mouseX / 300.0;
  //println(mix);
  fill(lerpColor(#d95b25, #25d97f, mix*mix));
  rect(40, 138, 70, -113 * mix); 
  image(battery, 0, 0);
  fill(0, 0, 0);
  textSize(96);
  int percentage = int(mix*101);
  text(percentage, 120, 110);
  if (percentage < 100) {
    textSize(48);
    text("%", 250, 110);
  }
}
