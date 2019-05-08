//int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
//int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399};
//int colors[] = {#845EC2, #D65DB1, #FF6F91, #FF9671, #FFC75F, #F9F871};
//int colors[] = {#A534C9, #F327A2, #FF5478, #FF8F58, #FFC650, #F9F871};
//int colors[] = {#E9E4CF, #EBD662, #CB4B86, #D8B4A4, #C89741, #A29282, #913439, #A1C8C0, #5F9AAA, #5A6062};
int colors[] = {#FFFFFF, #1F4979, #AAC4CE, #D1D4D4, #919091, #F2822C, #F1F2F3}; //ford
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

void generate() {
    int r = 30;
  background(150);
  for (int u = 10; u < width-20; u+=2 * r - r / 2) {
    for (int v = 10; v < height-20; v+= 2 * sqrt(r * r - r * r / 4)) {
      int count = u * (390 / (2 * r));
      int v_;
      print(count + "  ");
      if((count / 285) % 2 == 1)v_ = v + r; else v_ = v;
      noStroke();
      fill(rcol());
      beginShape();
      for (int i=0; i<6; i++) {
        float angle = i * 360 / 6 * (PI / 180);
        float x = u + r * cos(angle);
        float y = v_ + r * sin(angle);
        vertex(x + r, y + r);
      }
      endShape(CLOSE);
    }
  }
  saveImage();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void setup() {
  size(1080, 1080, P3D);
  smooth(8);
  pixelDensity(2);
  background(255);
  noStroke();
  generate();
}
