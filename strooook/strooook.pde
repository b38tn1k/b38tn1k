//int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
//int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399};
//int colors[] = {#845EC2, #D65DB1, #FF6F91, #FF9671, #FFC75F, #F9F871};
//int colors[] = {#A534C9, #F327A2, #FF5478, #FF8F58, #FFC650, #F9F871};

int colors[] = {#E9E4CF, #EBD662, #CB4B86, #D8B4A4, #C89741, #A29282, #913439, #A1C8C0, #5F9AAA, #5A6062};

//int colors[] = {#FFFFFF, #1F4979, #AAC4CE, #D1D4D4, #919091, #F2822C, #F1F2F3}; //ford

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
  int randomVal = width/10;
  int c1 = rcol();
  int c2 = rcol();
  int c3 = rcol();
  int c4 = rcol();
  float position;
  int col1;
  int col2;
  float yperc; 
  for (int i = 0; i < 120; i++) {
    for (int j = 100; j < height - 100; j+= 100) {
      position = height/5 + random(-1 * randomVal, randomVal);
      yperc = (((4*height)/5) - position)/((3*height)/5);
      col1 = lerpColor(c1, c3, yperc);
      col2 = lerpColor(c2, c4, yperc);
      strookxishdown(j, width-100, 75,  position, col1, col2);
    }
  }
  for (int i = 0; i < 120; i++) {
    for (int j = 100; j < height - 100; j+= 100) {
      position = height/2 + random(-1 * randomVal, randomVal);
      yperc = (((4*height)/5) - position)/((3*height)/5);
      col1 = lerpColor(c1, c3, yperc);
      col2 = lerpColor(c2, c4, yperc);
      strookxishdown(j, width-100, 75,  position, col1, col2);
    }
  }
  for (int i = 0; i < 120; i++) {
    for (int j = 100; j < height - 100; j+= 100) {
      position = (4*height)/5 + random(-1 * randomVal, randomVal);
      yperc = (((4*height)/5) - position)/((3*height)/5);
      col1 = lerpColor(c1, c3, yperc);
      col2 = lerpColor(c2, c4, yperc);
      strookxishdown(j, width-100, 75, position, col1, col2);
    }
  }
  //saveImage();
  //generate();
}

void strookx(float startx, float endx, float y, int cs, int ce) {
  noStroke();
  float radius = 1;
  float inc = 0.1;
  for (int i = int(startx); i <= endx; i++) {
    float xratio = (i-startx) / (endx - startx);
    fill(lerpColor(cs, ce, xratio));
    ellipse(i, y, radius, radius);
    radius += inc;
  }
}

void strookxishdown(float startx, float endx, float ish, float y, int cs, int ce) {
  noStroke();
  float radius = 1;
  float inc = 0.05;
  float posx = startx + random(-1*ish, ish);
  for (int i = int(posx); i <= endx; i++) {
    float xratio = (i-startx) / (endx - startx);
    fill(lerpColor(cs, ce, xratio));
    ellipse(y, i, radius, radius);
    radius += inc;
  }
}

void setup() {
  //size(1920, 1920, P2D);
  size(1080, 1080, P2D);
  
  smooth(8);
  pixelDensity(2);
  background(rcol());
  generate();
}

void draw() {
}
