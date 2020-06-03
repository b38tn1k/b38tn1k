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
float[][] terrain;
int cols, rows;

void generate(){
  // make array
  float res =0.0005;
  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = noise(xoff, yoff);
      xoff+=res*2;
    }
    yoff+=res;
    if (yoff > 1080/200){
      yoff = 0;
    }
  }
  
  //draw result
  int c1 = 0;
  stroke(c1);
  background(255);
  float level = 0;
  while (level < 1.0) {
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        if (terrain[x][y] > level - 0.0002 && terrain[x][y] < level + 0.0002) {
          point(y, x);
        }
      }
    }
    level += 0.01;
  }
}

void setup(){
  smooth(8);
  size(1080, 1080, P3D);
  pixelDensity(2);
  cols = w;
  rows = h;
  terrain = new float[cols+1][rows+1];
  generate();
}

void draw() {}
