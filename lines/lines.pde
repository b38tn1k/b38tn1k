int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
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
  background(255);
  
  int val = randint(100)+1;
  while (width % val != 0) {
    val = randint(100)+1;
  }
  for (int i = 0; i <= width; i += width/val) {
    for (int j = 0; j <= height; j += width/val) {
      stroke(rcol());
      line(i, 0, j, height);
      line(i, width, j, 0);
    }
  }
}

void setup() {
  size(1080, 1080, P3D);
  smooth(8);
  pixelDensity(2);
  background(255);
  generate();
}

void draw() {
}
