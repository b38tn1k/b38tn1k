//int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
//int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399};
int colors[] = {#845EC2, #D65DB1, #FF6F91, #FF9671, #FFC75F, #F9F871};
//int colors[] = {#A534C9, #F327A2, #FF5478, #FF8F58, #FFC650, #F9F871};


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
  saveFrame(timestamp+".png");
}

void generate() {
  int res = 16;
  for (int i = 0; i <= res; i++) {
   for (int j = 0; j <= res; j++) {
     square((i*width/res) + width/(2*res)-1, (j*height/res)+j/(2*res)-1, rcol(), rcol(), width/res+2, height/res+2);
   }
  }
}

void square(int x, int y, int col1, int col2, float l, float h) {
  pushMatrix();
  translate((x - l/2)+3, (y-h/2)+3);
  for (int i = 0; i < l; i++) {
    stroke(lerpColor(col1, col2, i/l));
    line(i, 0, i, h);
  }
  popMatrix();
}


void setup() {
  size(1080, 1080, P2D);
  smooth(8);
  pixelDensity(2);
  background(0);
  generate();
}

void draw() {
  //generate();
}
