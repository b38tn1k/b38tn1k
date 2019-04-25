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
  int pop = int(random(50)) + 1;
  int dims = int(random(width/pop));
  for (int i = 0; i < width; i+=(width/pop)) {
    for (int j = 0; j < width; j+=(width/pop)) {
      fill(colors[i %colors.length]);
       rect(i, j, dims, dims, randint(int(dims/4)), randint(int(dims/4)), randint(int(dims/4)), randint(int(dims/4)));
       fill(colors[j % colors.length]);
       ellipse(i + dims/2, j + dims/2, dims/2, dims/2);
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
