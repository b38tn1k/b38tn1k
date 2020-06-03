int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399, #FFFFFF};

int rcol() {
  return colors[int(random(colors.length))];
};

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

int h = 1080;
int w = 1080;
int scl = 1;
float[][] terrain;
int cols, rows;

void generate(){
  float res =0.1;
  float yoff = random(1000, 1000);
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = noise(xoff, yoff);
      xoff+=res*2;
    }
    yoff+=res;
    yoff = yoff%10;
  }
  int c1 = rcol();
  int c2 = rcol();
  while (c2 == c1) {c2 = rcol();}
  int cc = c1;
  float levelHeight = 0.1;
  float level = levelHeight;
  background(cc);
  while (level < 1.0) {
    stroke(cc);
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        if (terrain[x][y] > level) {
          point(y, x);
        }
      }
    }
    println(level);
    level += levelHeight;
    //cc = lerpColor(c1, c2, (level+levelHeight));
    cc = rcol();
  }
}

void setup(){
  smooth(8);
  size(1080, 1080, P3D);
  pixelDensity(2);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols+1][rows+1];
  generate();
}

void draw() {}
