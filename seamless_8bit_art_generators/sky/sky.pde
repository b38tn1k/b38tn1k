int colors[] = { #0D0D0D, #343434, #69450F, #A14111, #BB3F11, #BB2C38, #E73876, #A635A6, #DF46E2, #FC7DAC, #FBA076, #FAB265, #FBD99E, #EAF494, #C6F393, #CCCDCE, #D6D4D3, #F6DCC6, #FBE4C5, #F6D1E8, #FACCFD, #E1CBFC, #CBCFFC, #B7E6FB, #C1F1E5, #FDFAFD, #FFFFFF, #F59CFC, #A99AFA, #85ADFA, #4FBFF8, #13DEF7, #12D7E6, #139AF7, #138FF7, #1855F7, #1544CD, #5552CC, #7971F9, #969696, #6F6F6F, #0F5070, #118EA5, #11B270, #11B21D, #11BF1E, #108A19, #107D17, #0F6E16, #BA8711, #E7852F, #F96B13, #F8B013, #D5F02D, #71D87E, #6FF2BC};
int step = 1;
int skyBlue1 = #0a3fd5;
int skyBlue2 = #abe7fe;
int cloudWhite1 = #FFFFFF;
int cloudWhite2 = #d6d4d3;


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
  sky(0.05);
};

void sky(float noiseScale) {
  noiseSeed(int(random(1000)));
  noStroke();
  float map[][] = new float[width][height];
  for (int x=0; x < width + 100; x++) {
    for (int y=0; y < height; y++) {
      float noiseVal = noise(x*noiseScale, y*noiseScale);
      if (x < width) {
        map[x][y] = noiseVal;
      } else {
        int _x = x - width;
        float diff = float(x) - width;
        diff = diff / 100.0;
        
        map[_x][y] = diff * map[_x][y] + (1 - diff) * noiseVal; 
      }
    }
  }
  
  for (int x=0; x < width; x++) {
    for (int y=0; y < height; y++) {
      int skyBlue = lerpColor(skyBlue1,skyBlue2, float(y)/height * 3);
      int cloudWhite = lerpColor(cloudWhite1,cloudWhite2, float(y)/(2*height));
      int this_color = lerpColor(cloudWhite, skyBlue, map[x][y]);
      fill(this_color);
      rect(x, y, step, step);
    }
  }
};

void setup() {
  size(1080, 128);
  generate();
};

void draw() {
};
