int colors[] = {#F6511D, #FFB400, #00A6ED, #E56399, #FFFFFF};
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
  saveImage();
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
