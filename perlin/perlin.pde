int colors[] = {#F6511D, #FFB400, #00A6ED, #E56399, #FFFFFF};
int step = 3;
int skyBlue1 = #7894ef;
int skyBlue2 = #c6ffff;
int cloudWhite1 = #FFFFFF;
int cloudWhite2 = #8995b2;
//int farMountainColor1 = #8da2c8;
int farMountainColor1 = #c1cce1;
int farMountainColor2 = #5e748b;
int midMountainColor1 = #4e7e40;
int midMountainColor2 = #969f0d;
int shrubColor1 = #1c6610;
int shrubColor2 = #5c6e21;
int shrubColor3 = #0d4a03;
int shrubColor4 = #51660c;

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
  
  sky(0.009);
  int scale = 3;
  float noiseVal = 0.004;
  float pos = 0.8;
  int c1 = farMountainColor1;
  int c2 = farMountainColor2;
  int s1 = shrubColor1;
  int s2 = shrubColor3;
  int mountainCount = 7;
  float bumpScale = 0.001;
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
    forest(yheight, fw, fh, s1, 70);
    pos += 0.3;
    scale += 5;
    noiseVal -= 0.0005;
    bumpScale += 0.001;
    fw += 3;
    fh += 8;
    c1 = lerpColor(farMountainColor1, midMountainColor1, float(i)/mountainCount);
    c2 = lerpColor(farMountainColor2, midMountainColor2, float(i)/mountainCount);
    s1 = lerpColor(shrubColor2, shrubColor3, float(i)/mountainCount);
    s2 = lerpColor(shrubColor3, shrubColor4, float(i)/mountainCount);
  }
  grab = true;
};
 
void forest(int[] yheight, float w, float h, int tipColor, int gap) {
  for (int x = 0; x < width; x+=step) {
    if (rcoin()) {
      int ypos = int(random(yheight[int(x/step)], yheight[int(x/step)] + gap));
      color baseColor = lerpColor(get(x, ypos), get(x + 30, ypos), 0.5);
      w = w + random(-1, 1);
      h = h + random(-1, 1);
      tree1(x, ypos, w, h, tipColor, baseColor);
    }
  }
}

int[] mountains(int c1, int c2, int pos, int scale, float noiseScale, float bumpScale) {
  noiseSeed(int(random(1000)));
  noStroke();
  int[] yheight = new int[width/step];
  int midColor = lerpColor(c1, c2, 0.5);
  for (int x=0; x < width; x+=step) {
    float noiseVal = noise(x*noiseScale);
    int this_height = int(noiseVal * height/scale) + pos;
    this_height = int(this_height/step) * step;
    yheight[int(x/step)] = this_height;
    for (int y = this_height; y < height; y+=step) {
      float lerper = float(y - this_height) / (this_height);
      int this_color = lerpColor(c1, c2, lerper);
      // try add some bump noise?
      float bumpnoise = noise(x*bumpScale, y*bumpScale);
      //float otherNoise = noise(x*noiseScale*10, y*noiseScale*10);
      //bumpnoise = bumpnoise / otherNoise;
      this_color = lerpColor(this_color,midColor, bumpnoise);
      //
      fill(this_color);
      rect(x, y, step, step);
      //if (rcoin()) {
      //  tree1(x, y, 20, 50, shrubColor1, this_color);
      //}
    }
  }
  return yheight;
};

void tree1(float x, float y, float w, float h, int c1, int c2) {
  noStroke();
  x = x - w/2 * step;
  y = y - h/2 * step;
  for (int j = 0; j < h; j++) {
    int watp = int(sin((j/h)*2.5) * w);
    int watps = int((w - watp));
    for (int i = watps; i < watp; i++) {
      int col = lerpColor(c1, c2, j/h);
      fill(col);
      float _x = x + i * step;
      float _y = y + j * step;
      rect(_x, _y, step, step);
    }
  }
}

void sky(float noiseScale) {
  noiseSeed(int(random(1000)));
  noStroke();
  for (int x=0; x < width; x+=step) {
    for (int y=0; y < height; y+=step) {
      int skyBlue = lerpColor(skyBlue1,skyBlue2, float(y)/height * 3);
      int cloudWhite = lerpColor(cloudWhite1,cloudWhite2, float(y)/(2*height));
      float noiseVal = noise(x*noiseScale, y*noiseScale);
      //float otherNoise = noise(x*noiseScale*10, y*noiseScale*10);
      //noiseVal = noiseVal / otherNoise;
      int this_color = lerpColor(cloudWhite, skyBlue, noiseVal);
      fill(this_color);
      rect(x, y, step, step);
    }
  }
};

void setup() {
  size(1080, 1080);
  generate();
};

void draw() {
  if (grab) {
    bg = get();
    grab = false;
  }
  if (reset) {
    background(0);
    image(bg, 0, 0);
    reset = false;
  }
};
