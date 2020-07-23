int colors[] = {#F6511D, #FFB400, #00A6ED, #E56399, #FFFFFF};
int step = 1;
int farMountainColor1 = #7cadff;
int farMountainColor2 = #b9f686;
int midMountainColor1 = #00b669;
int midMountainColor2 = #6f4400;

float transition = 0.0;

PImage bg;
boolean grab = false;
boolean reset = false;

int rcol() {
  return colors[int(random(colors.length))];
};

int rcolsub(int colors[], int len) {
  return colors[int(random(len))];
};

boolean coin() {
  return random(1) > .5;
};

boolean rcoin() {
  return random(1) > .95;
};

int randint(int x) {
  return int(random(x));
};



void keyPressed() {
  if (key == 's') {
    saveImage();
  } else if (key == 'r') {
    reset = true;
  } else {
    generate();
  }
};

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
};



void generate() {
  
  saveImage();
  clear();
  background(255, 0, 255);
  transition += 0.01;
  int scale = 1;
  float noiseVal = 0.05;
  float pos = 0.8;
  int c1 = farMountainColor1;
  int c2 = farMountainColor2;
  int mountainCount =4;
  float bumpScale = 0.01;
  int mountainPos = int((height/3)*pos);
  int mountainGap;
  int[] yheight;
  int fw = 2;
  int fh = 4;
  for (int i = 0; i < mountainCount; i++) {
    int temp = int((height/3)*pos);
    mountainGap = temp - mountainPos; 
    mountainPos = temp;
    yheight = mountains(c1, c2, mountainPos, scale, noiseVal, bumpScale);
    //forest(yheight, fw, fh, s1, 70);
    pos += 0.3;
    scale += 5;
    noiseVal -= 0.0005;
    bumpScale += 0.001;
    fw += 3;
    fh += 8;
    c1 = lerpColor(farMountainColor1, midMountainColor1, float(i)/mountainCount);
    c2 = lerpColor(farMountainColor2, midMountainColor2, float(i)/mountainCount);
  }
  grab = true;
};

int[] mountains(int c1, int c2, int pos, int scale, float noiseScale, float bumpScale) {
  noiseSeed(int(random(1000)));
  noStroke();
  int[] yheight = new int[width/step];
  int midColor = lerpColor(c1, c2, 0.5);
  int blend = 0;
  for (int x=0; x < width; x+=step) {
    float noiseVal = noise(x*noiseScale);
    if (blend < 10) {
      float diff = blend / 10.0;
      noiseVal = (diff * noiseVal) + ((1 - diff) * noise((width - blend)*noiseScale));
    } else {
      noiseVal = noise(x*noiseScale);
    }
    int this_height = int(noiseVal * height/scale) + pos;
    this_height = int(this_height/step) * step;
    yheight[int(x/step)] = this_height;
    for (int y = this_height; y < height; y+=step) {
      float lerper = float(y - this_height) / (this_height);
      int this_color = lerpColor(c1, c2, lerper);
      //float bumpnoise = noise(x*bumpScale, y*bumpScale);
      //this_color = lerpColor(this_color,midColor, bumpnoise);
      fill(this_color);
      rect(x, y, step, step);
    }
    blend ++;
  }
  return yheight;
};

void setup() {
  size(1080, 128);
  generate();
};

void draw() {
};
