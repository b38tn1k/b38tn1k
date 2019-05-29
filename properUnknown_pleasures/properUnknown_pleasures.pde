//int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
//int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399};
//int colors[] = {#845EC2, #D65DB1, #FF6F91, #FF9671, #FFC75F, #F9F871};
//int colors[] = {#A534C9, #F327A2, #FF5478, #FF8F58, #FFC650, #F9F871};
//int colors[] = {#E9E4CF, #EBD662, #CB4B86, #D8B4A4, #C89741, #A29282, #913439, #A1C8C0, #5F9AAA, #5A6062};
//int colors[] = {#FFFFFF, #1F4979, #AAC4CE, #D1D4D4, #919091, #F2822C, #F1F2F3}; //ford
int colors[] = {#ff71ce, #01cdfe, #05ffa1, #b967ff, #fffb96}; //vaporwave
//https://palettegenerator.com/ 

int rcol() {
  return colors[int(random(colors.length))];
};

boolean coin() {
  return random(1) > .5;
}

int randint(int x) {
  return int(random(x));
}

void keyPressed() {
  if (key == 's') {
    saveImage();
  } else {
    generate();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  println(timestamp);
  saveFrame(timestamp+".png");
}

void generate() {
  background(rcol());
  strokeWeight(2.5);
  stroke(rcol());
  int c1 = rcol();
  int c2 = rcol();
  fill(c1);
  
  String[] data = loadStrings("pulsar.csv");
  for (int i = 0; i < data.length; i++) {
    float[] points = float(split(data[i],','));
    beginShape();
    for (int j = 0; j < 300; j++) {
      vertex(100 + 2 * j, -80 + height - (8 * (79 - i) + 2 * points[j]));
    }
    endShape();
    fill(lerpColor(c1, c2, float(i)/data.length));
  }
  //noLoop();
  saveImage();
  generate();
}

void setup() {
  size(800, 800, P2D);
  smooth(8);
  pixelDensity(2);
  background(255);
  generate();
}

void draw() {
}
