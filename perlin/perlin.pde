//int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
//green = #7FB800
//int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399, #FFFFFF};
int colors[] = {#F6511D, #FFB400, #00A6ED, #E56399, #FFFFFF};
int rcol() {
  return colors[int(random(colors.length))];
};

int rcolsub(int colors[], int len) {
  return colors[int(random(len))];
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

int step = 1;
int skyBlue1 = #7894ef;
int skyBlue2 = #c6ffff;
int cloudWhite1 = #FFFFFF;
int cloudWhite2 = #8995b2;
int farMountainColor1 = #8da2c8;
int farMountainColor2 = #5e748b;
int midMountainColor1 = #4e7e40;
int midMountainColor2 = #969f0d;

void generate() {
  sky();
  int scale = 3;
  float noiseVal = 0.004;
  float pos = 0.8;
  int c1 = farMountainColor1;
  int c2 = farMountainColor2;
  int mountainCount = 5;
  for (int i = 0; i < mountainCount; i++) {
    mountains(c1, c2, int((height/3)*pos), scale, noiseVal);
    pos += 0.2;
    scale += 1;
    noiseVal -= 0.0005;
    c1 = lerpColor(farMountainColor1, midMountainColor1, float(i)/mountainCount);
    c2 = lerpColor(farMountainColor2, midMountainColor2, float(i)/mountainCount);
  }
  int flowercount = 30;
  for (int i = 0; i < flowercount; i++) {
    flower(int(random(0, width)), int(random(0.66*height, height)));
  }
}

void mountains(int c1, int c2, int pos, int scale, float noiseScale) {
  noiseSeed(int(random(1000)));
  noStroke();
  for (int x=0; x < width; x+=step) {
    float noiseVal = noise(x*noiseScale);
    println(noiseVal);
    int this_height = int(noiseVal * height/scale) + pos;
    this_height = int(this_height/step) * step;
    for (int y = this_height; y < height; y+=step) {
      float lerper = float(y - this_height) / (this_height);
      int this_color = lerpColor(c1, c2, lerper);
      fill(this_color);
      rect(x, y, step, step);
    }
  }
}

void sky() {
  float noiseScale = 0.009;
  noiseSeed(int(random(1000)));
  noStroke();
  for (int x=0; x < width; x+=step) {
    for (int y=0; y < height; y+=step) {
      int skyBlue = lerpColor(skyBlue1,skyBlue2, float(y)/height * 3);
      int cloudWhite = lerpColor(cloudWhite1,cloudWhite2, float(y)/(2*height));
      float noiseVal = noise(x*noiseScale, y*noiseScale);
      int this_color = lerpColor(cloudWhite, skyBlue, noiseVal); 
      fill(this_color);
      rect(x, y, step, step);
    }
  }
}

void flower(int x, int y) {
  int radius = int(random(20, 50));
  float centerbit = random(0.2, 0.8);
  int stemlength = int(random(40, 80));
  // the stem
  int stemwidth = int(random(2, 4));
  
  fill(#7FB800);
  rect(x, y, stemwidth, stemlength);
  
  // petals
  ellipseMode(CENTER);
  int petalCount = int(random(4, 20));
  float petalAngle = 180/petalCount;
  int colorcount = int(random(1, 4));
  int thisFlower[] = {rcol(), rcol(), rcol(), rcol(), rcol()};
  for (int i = 180; i >= 0; i-=petalAngle) {
    fill(rcolsub(thisFlower, colorcount));
    pushMatrix();
    translate(x, y);
    rotate(radians(i));
    ellipse(0, 0, radius, radius/petalCount);
    ellipse(0, 0, radius/petalCount, radius);
    fill(255, 255, 255, 40);
    ellipse(0, 0, radius, centerbit*(radius/petalCount));
    ellipse(0, 0, centerbit*(radius/petalCount), radius);
    popMatrix();
  } 
}

void setup() {
  size(1080, 1080);
  generate();
}

//void mouseClicked() {
// flower(mouseX, mouseY); 
//}




void draw() {
}
