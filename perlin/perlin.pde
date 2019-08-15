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

float noiseScale = 0.009;

void generate() {
  noiseSeed(int(random(1000)));
  for (int x=0; x < width; x++) {
    for (int y=0; y < height; y++) {
      float noiseVal = noise(x*noiseScale, y*noiseScale);
      //stroke(noiseVal*255);
      stroke(lerpColor(#FFFFFF, #00A6ED, noiseVal)); 
      point(x, y);
    }
  }
}

void setup() {
  size(1080, 1080);
  generate();
}



void draw() {
}
